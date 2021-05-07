<template>
  <b-container>
    <b-row>
      <div class="mx-auto">
        <h2>API Test</h2>
      </div>
    </b-row>

    <b-row>
      <b-col md="2"></b-col>
      <b-col md="8">
        <TestComponent />
      </b-col>
      <b-col md="2"></b-col>
    </b-row>
  </b-container>
</template>

<script>
import TestComponent from "../components/TestComponent.vue";
export default {
  name: "Test",
  components: {
    TestComponent,
  },
};
</script>

<style scoped>
</style>