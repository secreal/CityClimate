import http from "./http";

const climateApi = {
    endPoint: "api/climate",

    async get(city) {
        const response = await http.get(this.endPoint + `/${city}/get`);
        return response.data;
    },
    
};

export default climateApi;
