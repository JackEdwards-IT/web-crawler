<template>
  <b-container>
    <h2>User Dashboard</h2>
    <button @click="logoutUser()">Logout</button>
  </b-container>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "dashboard",
  methods: {
    ...mapActions(["logout"]),
    logoutUser() {
      console.log("Logging out user...");
      this.logout();
    },
  },
};
</script>

<style scoped>
</style>