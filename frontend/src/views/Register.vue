<template>
    <b-container>
        <b-row>
      <div class="mx-auto">
        <h2>Register</h2>
      </div>
    </b-row>

    <b-row>
      <b-col cols="0" md="4"></b-col>

      <b-col cols="12" md="4">
        <b-form class="register" @submit="onSubmit">


           <b-form-group
            id="firstname-input-group"
            label="First Name:"
            label-for="firstname-input"
          >
            <b-form-input
              id="firstname-input"
              type="text"
              v-model="firstname"
              aria-placeholder="Enter your firstname"
              required
              autofocus
            ></b-form-input>
          </b-form-group>

             <b-form-group
            id="secondname-input-group"
            label="Last Name:"
            label-for="lastname-input"
          >
            <b-form-input
              id="lastname-input"
              type="text"
              v-model="lastname"
              aria-placeholder="Enter your lastname"
              required
              autofocus
            ></b-form-input>
          </b-form-group>
       
       
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
              aria-describedby="pw-helper"
              required
            ></b-form-input>
            <b-form-text id="pw-helper">
                Password must be a minimum lenght of 5 characters.
            </b-form-text>
          </b-form-group>

          <b-button type="submit">
            <b-spinner small class="login" v-if="showSpinner"></b-spinner>
            Register
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

export default{
    name: 'Register',
    data() {
    return {
      email: "jack@je-it.com",
      password: "password123",
      firstname: "Jack",
      lastname: "Edwards",
    };
  },
}
</script>

<style scoped>

</style>