<template>
  <b-container>
    <b-row class="mt-5">
      <b-col md="2"></b-col>
      <b-col md="8">
        <h1>Ebay Crawler</h1>
      </b-col>
      <b-col md="2"></b-col>
    </b-row>

    <b-row>
      <b-col md="2"></b-col>
      <b-col md="8">
        <p>
          A simple web crawler that allows you to track prices of ebay listings
          and set alerts.
        </p>
      </b-col>
      <b-col md="2"></b-col>
    </b-row>

    <b-row>
      <b-col md="2"></b-col>
      <b-col md="8">
        <router-link to="/login">
          <b-button class="mr-2">Sign In</b-button>
        </router-link>

        <router-link to="/register">
        <b-button class="mr-2">Register</b-button>
        </router-link>

         <router-link to="/test">
        <b-button>Test API connection</b-button>
        </router-link>

      </b-col>
      <b-col md="2"></b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: "Home",
};
</script>
