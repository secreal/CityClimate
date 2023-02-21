import Vue from "vue";
import VueRouter from "vue-router";
import AppLayout from "@src/layouts/AppLayout.vue";
import Home from "@src/views/Home.vue";


Vue.use(VueRouter);

const routes = [
    {
        path: "/",
        component: AppLayout,
        children: [
            {
                path: "",
                component: Home
            },
        ],
    },

];

const router = new VueRouter({
    routes,
});

export default router;
