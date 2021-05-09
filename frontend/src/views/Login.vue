<template>
  <b-container>
    <h2>Login</h2>
    <form class="login" @submit="onSubmit">
      <label for="email">E-Mail Address</label>
      <div>
        <input id="email" type="email" v-model="email" required autofocus />
      </div>
      <div>
        <label for="password">Password</label>
        <div>
          <input id="password" type="password" v-model="password" required />
        </div>
      </div>
      <div>
        <b-button type="submit">
          <b-spinner small class="login"></b-spinner>
          <span class="sr-only">Login</span>
        </b-button>
        <b-alert variant="danger" :show="error">Problem with login.</b-alert>
      </div>
    </form>
  </b-container>
</template>

<script>
import { mapActions, mapState } from "vuex";

export default {
  name: "login",
  data() {
    return {
       email: "jack@je-it.com", 
       password: "password123",
       error: false
    };
  },
  methods: {
    ...mapActions(["loginUser"]),
    onSubmit(e) {
      var user = {email: this.email, password: this.password};
      console.log("TEST: " + JSON.stringify(user));
      e.preventDefault();
      this.loginUser(user);
    },
  },
  computed: mapState(['status'])
};
</script>

<style scoped>
</style>