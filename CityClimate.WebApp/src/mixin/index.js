import XLSX from "xlsx";
import store from "@/store";

export default {
    methods: {
        vuexFromStorage(key) {
            store.commit(`base/${key}`, this.storageLoad(key) ?? "");
            // console.log(key)
            // console.log(this.storageLoad(key))
        },        
        getErrorMessage(error) {
            if (error?.response?.data?.message) return error?.response?.data?.message;
            else if (error?.message) return error?.message;
            else return error;
        },

        getErrorStatusCode(error) {
            if (error?.response?.status) return error?.response?.status;
            else return "999";
        },

        showErrorMessage(error) {
            this.$root.snackbar.showError(error);
        },

        today() {
            return new Date().toISOString().slice(0, 10);
        },

        round(number, digits = 2) {
            if (isNaN(number) || isNaN(digits)) return "";
            return parseFloat(number.toFixed(digits));
        },

        formatDate(date) {
            if (!date) return "";
            date = new Date(date);
            return date.toLocaleDateString("id-ID");
        },

        formatNumber(number) {
            if (isNaN(number)) return "0";
            if (number) return Number(number).toLocaleString("id-ID");
            return "0";
        },

        parseDate(date) {
            return date.substring(0, 10);
        },

        parseNumber(number) {
            if (isNaN(number)) return 0;

            if (number) return Number(number);
            return 0;
        },

        encryptString(text) {
            if (!text) return "";
            const x = btoa(unescape(encodeURIComponent(text)));
            const y = x.split("").reverse().join("");
            const z = btoa(y);
            return z;
        },

        decryptString(text) {
            if (!text) return "";
            const z = decodeURIComponent(escape(atob(text)));
            const y = z.split("").reverse().join("");
            const x = atob(y);
            return x;
        },

        storageSave(key, value) {
            const json = JSON.stringify(value);
            // const encryptedValue = this.encryptString(json);
            // const encryptedKey = this.encryptString(key);
            localStorage.setItem(key, json);
        },

        storageLoad(key) {
            try {
                // const encryptedKey = this.encryptString(key);
                // const encryptedValue = localStorage.getItem(key);
                // const json = this.decryptString(encryptedValue);
                return JSON.parse(localStorage.getItem(key));
            } catch {
                return null;
            }
        },

        storageRemove(key) {
            const encryptedKey = this.encryptString(key);
            localStorage.removeItem(encryptedKey);
        },

        sessionSave(key, value) {
            const json = JSON.stringify(value);
            sessionStorage.setItem(key, json);
        },

        sessionLoad(key) {
            try {
                const json = sessionStorage.getItem(key);
                return JSON.parse(json);
            } catch {
                return null;
            }
        },

        sessionRemove(key) {
            sessionStorage.removeItem(key);
        },

        downloadExcel(datasource, filename) {
            if (datasource) {
                const data = XLSX.utils.json_to_sheet(datasource);
                const wb = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(wb, data, "Data");
                XLSX.writeFile(wb, filename);
            }
        },

        downloadFile(url, fileName) {
            const a = document.createElement("a");
            a.href = url;
            a.setAttribute("download", fileName);
            a.style.visibility = "hidden";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        },
        
        downloadBlob(content, fileName) {
            const a = document.createElement("a");
            const objectURL = URL.createObjectURL(new Blob([content]));
            a.setAttribute("href", objectURL)
            a.setAttribute("download", fileName);
            a.style.visibility = "hidden";
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        },

        createRecord(datasource, resource) {
            datasource.push(resource);
        },

        updateRecord(datasource, resource) {
            let item = datasource.filter(x => x.id === resource.id)[0];
            const index = datasource.indexOf(item);
            datasource.splice(index, 1, resource);
        },

        deleteRecord(datasource, id) {
            const item = datasource.filter(x => x.id === id)[0];
            const index = datasource.indexOf(item);
            datasource.splice(index, 1);
        },
    },
};
