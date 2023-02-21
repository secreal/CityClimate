import http from "./http";

const countryApi = {
    endPoint: "api/country",

    async getAll() {
        const response = await http.get(this.endPoint + `/getall`);
        return response.data;
    },
    async getCity(cityCode) {
        const response = await http.get(this.endPoint + `/${cityCode}/cities`);
        return response.data;
    },
};

export default countryApi;
