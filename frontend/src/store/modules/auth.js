import axios from 'axios';

const state = {
    token: localStorage.getItem("user-token") || "",
    status: "",
    hasLoadedOnce: false
};

const getters = {
    isAuthenticated: state => !!state.token,
    authStatus: state => state.status
};

const actions = {
    // Login user
    async loginUser({commit}, user) {
        try {
            console.log("--logging user--\n" + JSON.stringify(user));
            const response = await axios.post("http://localhost:3001/api/user/login", user);
            console.log(response);
            console.log("\n");
            console.log(state);
            
            commit('test', response.data);
        } catch (error) {
            console.log("--ERROR OCCURRED---");
            console.log(error);
        }
    }

}

const mutations = {
    test: (state, token) => (state.token = token)
}

export default {
    state,
    actions,
    getters,
    mutations
}

//     [AUTH_REQUEST]: ({
//         commit,
//         dispatch
//     }, user) => {
//         return new Promise((resolve, reject) => {
//             commit(AUTH_REQUEST);
//             apiCall({
//                     url: "auth",
//                     data: user,
//                     method: "POST"
//                 })
//                 .then(resp => {
//                     localStorage.setItem("user-token", resp.token);
//                     // Here set the header of your ajax library to the token value.
//                     // example with axios
//                     // axios.defaults.headers.common['Authorization'] = resp.token
//                     commit(AUTH_SUCCESS, resp);
//                     dispatch(USER_REQUEST);
//                     resolve(resp);
//                 })
//                 .catch(err => {
//                     commit(AUTH_ERROR, err);
//                     localStorage.removeItem("user-token");
//                     reject(err);
//                 });
//         });
//     },
//     [AUTH_LOGOUT]: ({
//         commit
//     }) => {
//         return new Promise(resolve => {
//             commit(AUTH_LOGOUT);
//             localStorage.removeItem("user-token");
//             resolve();
//         });
//     }
// };

// const mutations = {
//     [AUTH_REQUEST]: state => {
//         state.status = "loading";
//     },
//     [AUTH_SUCCESS]: (state, resp) => {
//         state.status = "success";
//         state.token = resp.token;
//         state.hasLoadedOnce = true;
//     },
//     [AUTH_ERROR]: state => {
//         state.status = "error";
//         state.hasLoadedOnce = true;
//     },
//     [AUTH_LOGOUT]: state => {
//         state.token = "";
//     }
// };

// export default {
//     state,
//     getters,
//     actions,
//     mutations
// };