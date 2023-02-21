import store from "@src/store";
import mixin from "@src/mixin";
import axios from "axios";
import router from "@src/router";

const http = axios.create({
    baseURL: process.env.VUE_APP_API_URL,
    timeout: 360000,
});

http.interceptors.request.use(request => {
    let identity = store.getters["auth/identity"];
    
    if (!identity) {
        identity = mixin.methods.storageLoad("identity");
        store.commit("auth/identity", identity);
    }

    if (identity)
        request.headers.Authorization = `Bearer ${identity.accessToken}`;
    
    return request;
});

http.interceptors.response.use(
    response => response,
    async error => {
        if (error.response && error.response.status === 401) {

            if (error.config.url === 'api/auth/refresh-token') {
                await router.push("/login");
                return Promise.reject(error);
            }

            const refreshTokenRequest = {
                refreshToken: mixin.methods.storageLoad("refresh-token")
            };
            const newIdentity = (await http.post("api/auth/refresh-token", refreshTokenRequest)).data;
            store.commit("auth/identity", newIdentity);
            mixin.methods.storageSave("identity", newIdentity);

            return http(error.config);
        }
        return Promise.reject(error);
    });

export default http;

