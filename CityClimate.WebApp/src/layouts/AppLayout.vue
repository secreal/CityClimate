<template>
  <v-app id="app">
    <v-main>
      <router-view></router-view>
      <v-footer absolute color="grey lighten-4">

      </v-footer>
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: "AppLayout",
  data() {
    return {
      drawer: null,
    };
  },

  computed: {
    identity() {
    },
  },

  async mounted() {
  },

  methods: {},
};
</script>
