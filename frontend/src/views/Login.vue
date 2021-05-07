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
        <button type="submit">Login</button>
      </div>
    </form>
  </b-container>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "login",
  data() {
    return {
       email: "jack@je-it.com", 
       password: "password123",
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
};
</script>

<style scoped>
</style>