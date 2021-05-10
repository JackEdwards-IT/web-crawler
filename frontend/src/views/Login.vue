<template>
  <b-container>
    <b-row>
      <div class="mx-auto">
        <h2>Login</h2>
      </div>
    </b-row>

    <b-row>
      <b-col cols="0" md="4"></b-col>

      <b-col cols="12" md="4">
        <b-form class="login" @submit="onSubmit">
          <b-form-group
            id="email-input-group"
            label="Email Address:"
            label-for="email-input"
          >
            <b-form-input
              id="email-input"
              type="email"
              v-model="email"
              aria-placeholder="Enter email"
              required
              autofocus
            ></b-form-input>
          </b-form-group>

          <b-form-group
            id="password-input-group"
            label="Password:"
            label-for="password-input"
          >
            <b-form-input
              id="password-input"
              v-model="password"
              placeholder="Enter Password"
              type="password"
              required
            ></b-form-input>
          </b-form-group>

          <b-button type="submit">
            <b-spinner small class="login" v-if="showSpinner"></b-spinner>
            Login
          </b-button>
          <b-alert variant="danger" :show="loginError"
            >Problem with login.</b-alert
          >
        </b-form>
      </b-col>
      <b-col cols="0" md="4"></b-col>
    </b-row>
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
      loginError: true,
      showSpinner: false,
    };
  },
  methods: {
    ...mapActions(["loginUser"]),
    onSubmit(e) {
      this.showSpinner = true;
      var user = { email: this.email, password: this.password };
      console.log("TEST: " + JSON.stringify(user));
      e.preventDefault();
      this.loginUser(user);
    },
  },
  computed: mapState(["status"]),
};
</script>

<style scoped>  
  
</style>