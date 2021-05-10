<template>
  <b-container>
    <b-navbar toggleable="md" type="dark" variant="dark">
      <b-navbar-toggle target="navbar-toggle-collapse">
        <template #default="{ expanded }">
          <b-icon v-if="expanded" icon="list"></b-icon>
          <b-icon v-else icon="list"></b-icon>
        </template>
      </b-navbar-toggle>

      <b-collapse id="navbar-toggle-collapse" is-nav>
        <b-navbar-nav class="mr-auto">
          <router-link to="/" class="mr-2">Home</router-link>
          <router-link to="/login" class="mr-2">Login</router-link>
          <router-link to="/register" class="mr-2">Register</router-link>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </b-container>
</template>

<script>
export default {
  name: "Navbar",
  data() {
    return {
    
    };
  },
};
</script>

<style scoped>
a{
    color: black;
    font-size: 20px;
}
</style>