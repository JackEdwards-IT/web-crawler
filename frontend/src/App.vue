<template>
  <b-container>
  <navbar v-show="showNavBar"></navbar>
  <router-view/>
  </b-container>
</template>

<script>
import navbar from "@/components/Navbar.vue";
export default {
  name: 'App',
  components: { navbar: navbar },
  computed: {
    showNavBar(){
    if (this.$route.path === "/"){
      return false;
    } else {
      return true;
    }
    }
  }
};

</script>

<style>
/* Fonts */
/* Zen Dots */
@import url('https://fonts.googleapis.com/css2?family=Zen+Dots&display=swap');
/* Noto Sans JP */
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+JP&display=swap');

h1{
  font-family: 'Zen Dots';
}
p {
  font-family: 'Noto Sans JP';
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
