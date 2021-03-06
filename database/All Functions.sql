CREATE OR REPLACE FUNCTION convertIban (amount numeric, from_code varchar, to_code varchar)
    RETURNS numeric
    AS $func$
DECLARE
    result numeric;
    rate1 numeric;
    rate2 numeric;
BEGIN
    SELECT
        rate
    FROM
        ibanrates
    WHERE
        code = from_code INTO rate1;
    SELECT
        rate
    FROM
        ibanrates
    WHERE
        code = to_code INTO rate2;
    result := amount * (rate2 / rate1);
    RETURN result;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ibanUpdate (currency_code varchar, currency_rate numeric)
    RETURNS text
    AS $func$
BEGIN
    UPDATE
        ibanrates
    SET
        rate = currency_rate,
        last_updated = NOW()
    WHERE
        code = currency_code;
    IF NOT found THEN
        RETURN 'Currency code not found in database';
    ELSE
        RETURN 'Currency rate updated';
    END IF;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addEbayItem (arg_user int, arg_link varchar, arg_description varchar, arg_price numeric, arg_interval int, notify_change boolean DEFAULT NULL, price_increase boolean DEFAULT NULL, change_amount numeric DEFAULT NULL, arg_image varchar DEFAULT NULL, arg_endtime varchar DEFAULT NULL)
    RETURNS text
    AS $func$
DECLARE
    linkid int;
BEGIN
    INSERT INTO ebaylinks (user_id, link, link_description, initial_price, current_price, crawl_interval, last_crawled, link_valid, image, endtime)
        VALUES ($1, $2, $3, $4, $4, $5, NOW(), TRUE, $9, $10);
    linkid := currval(pg_get_serial_sequence('ebaylinks', 'id'));
    INSERT INTO ebaylinkhistory (link_id, time_crawled, price)
        VALUES (linkid, NOW(), $4);
    IF $6 = TRUE THEN
        IF $7 = TRUE THEN
            INSERT INTO ebayemail (link_id, price_increase, notification_amount)
                VALUES (linkid, 'TRUE', ($4 + $8));
            ELSEIF $7 = FALSE THEN
            INSERT INTO ebayemail (link_id, price_increase, notification_amount)
                VALUES (linkid, 'FALSE', ($4 - $8));
        END IF;
    END IF;
    RETURN 'Link added';
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION checkEbayNotifications ()
    RETURNS TABLE (
        user_id int,
        name varchar,
        email varchar,
        current_price numeric,
        notification_amount numeric,
        product_name varchar,
        initial_price numeric,
        product_link varchar,
        ebayemail_id int)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        ebaylinks.user_id,
        users.first_name,
        users.email,
        ebaylinks.current_price,
        ebayemail.notification_amount,
        ebaylinks.link_description,
        ebaylinks.initial_price,
        ebaylinks.link,
        ebayemail.id
    FROM
        ebaylinks
        INNER JOIN ebayemail ON link_id = ebaylinks.id
        INNER JOIN users ON ebaylinks.user_id = users.id
    WHERE
        CASE WHEN ebayemail.price_increase = TRUE THEN
            ebaylinks.current_price >= ebayemail.notification_amount
        WHEN ebayemail.price_increase = FALSE THEN
            ebaylinks.current_price <= ebayemail.notification_amount
        END;
END;
$$;

CREATE OR REPLACE FUNCTION deleteEbayNotification (int[])
    RETURNS void
    AS $func$
DECLARE
    x int[];
BEGIN
    FOREACH x SLICE 1 IN ARRAY $1 LOOP
        DELETE FROM ebayEmail
        WHERE id = x[1];
        RAISE NOTICE 'Notification data deleted';
    END LOOP;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getEbayUpdateList ()
    RETURNS TABLE (
        link_id int,
        link varchar)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        id,
        "ebaylinks".link
    FROM
        ebaylinks
    WHERE
        EXTRACT(EPOCH FROM (now() - last_crawled)) > "ebaylinks".crawl_interval * 60 * 60
        AND link_valid = TRUE;
END;
$$;

CREATE OR REPLACE FUNCTION setEbayLinkStatus (int[])
    RETURNS void
    AS $func$
DECLARE
    x int[];
BEGIN
    FOREACH x SLICE 1 IN ARRAY $1 LOOP
        UPDATE
            ebaylinks
        SET
            link_valid = 'FALSE'
        WHERE
            id = x[1];
        RAISE NOTICE 'Link status changed to FALSE';
    END LOOP;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION updateEbayPrice (numeric[])
    RETURNS void
    AS $func$
DECLARE
    x numeric[];
BEGIN
    FOREACH x SLICE 1 IN ARRAY $1 LOOP
        INSERT INTO ebaylinkhistory (link_id, price, time_crawled)
            VALUES (x[1], x[2], NOW());
        UPDATE
            ebaylinks
        SET
            last_crawled = NOW(),
            current_price = x[2]
        WHERE
            id = x[1];
        RAISE NOTICE 'item updated';
    END LOOP;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION updateLink (arg_id int, arg_interval int)
    RETURNS text
    AS $func$
BEGIN
    UPDATE
        ebaylinks
    SET
        crawl_interval = arg_interval
    WHERE
        id = arg_id;
    IF NOT FOUND THEN
        RETURN 'Link not found';
    ELSE
        RETURN 'link updated';
    END IF;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION addUser (varchar(130), varchar(130), varchar(130), varchar(20), varchar)
    RETURNS text
    AS $func$
BEGIN
    INSERT INTO users (first_name, last_name, email, ROLE, pass_hash, created_at)
        VALUES ($1, $2, LOWER($3), LOWER($4), crypt($5, gen_salt('bf', 12)), NOW());
    RETURN 'User created.';
EXCEPTION
    WHEN unique_violation THEN
        RETURN 'User already exists.';
END;

$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION deleteUser (arg_userID int)
    RETURNS text
    AS $func$
BEGIN
    DELETE FROM users
    WHERE id = arg_userID;
    IF NOT found THEN
        RETURN 'no user by that id';
    ELSE
        RETURN 'user deleted';
    END IF;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getUser (arg_email varchar(130), pass varchar)
    RETURNS TABLE (
        id int,
        first_name varchar(130),
        last_name varchar(130),
        ROLE VARCHAR(20),
        email varchar(130)
    )
    AS $func$
BEGIN
    RETURN QUERY
    SELECT
        "users".id,
        "users".first_name,
        "users".last_name,
        "users".role,
        "users".email
    FROM
        users
    WHERE
        "users".email = arg_email
        AND "users".pass_hash = crypt($2, "users".pass_hash);
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getUsers (arg_limit integer, arg_offset integer, rolesort varchar DEFAULT NULL)
    RETURNS TABLE (
        id integer,
        First_Name varchar,
        Last_Name varchar,
        Email varchar,
        ROLE VARCHAR,
        Created timestamp
    )
    AS $func$
BEGIN
    IF rolesort IS NULL THEN
        RETURN QUERY
        SELECT
            "users".id,
            "users".first_name,
            "users".last_name,
            "users".email,
            "users".role,
            "users".created_at
        FROM
            users
        ORDER BY
            "users".id ASC OFFSET arg_offset
        LIMIT arg_limit;
    ELSE
        RETURN QUERY
        SELECT
            "users".id,
            "users".first_name,
            "users".last_name,
            "users".email,
            "users".role,
            "users".created_at
        FROM
            users
        WHERE
            "users".role = rolesort
        ORDER BY
            "users".id ASC OFFSET arg_offset
        LIMIT arg_limit;
    END IF;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION resetPassword (arg_firstname varchar(130), arg_lastname varchar(130), arg_email varchar(130), new_password varchar)
    RETURNS text
    AS $func$
BEGIN
    UPDATE
        users
    SET
        pass_hash = crypt($4, gen_salt('bf', 12))
    WHERE
        email = $3
        AND LOWER(first_name) = LOWER($1)
        AND LOWER(last_name) = LOWER($2);
    IF NOT FOUND THEN
        RETURN 'User not found';
    ELSE
        RETURN 'Password was reset';
    END IF;
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION updateUser (arg_id int, arg_first varchar(130), arg_last varchar(130), arg_email varchar(130))
    RETURNS void
    AS $func$
BEGIN
    UPDATE
        users
    SET
        first_name = arg_first,
        last_name = arg_last,
        email = LOWER(arg_email)
    WHERE
        id = arg_id;
END;
$func$
LANGUAGE plpgsql;

