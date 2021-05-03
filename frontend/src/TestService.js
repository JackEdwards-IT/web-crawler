import axios from 'axios';

const url = 'http://localhost:3001/api/demo/'

class TestService {
    // Get test table

    static getTable() {
        return new Promise((resolve, reject) => {
            axios.get(url).then((res) => {
                    const data = res.data;
                    resolve(
                        data.map(table => ({
                            ...table
                        }))
                    );

                })
                .catch((err) => {
                    reject(err);
                })

        });
    }
    // Add to table
    static InsertData(text) {
        return axios.post(url, {
            text
        })
    }
    // Delete from table
    static DeleteData(id) {
        return axios.delete(`${url}${id}`);
    }
}
export default TestService;