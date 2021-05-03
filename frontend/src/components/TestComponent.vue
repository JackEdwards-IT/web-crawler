<template>
  <div class>
    <h3>Demo Table</h3> 
    <hr>
    <p class="error" v-if="error">{{error}}</p>
    
    <!-- Bootstrap-vue auto loads table data -->
    <b-table striped :items="tables" :fields="fields"></b-table>

    <!-- How to do the table manually -->
    <!-- <table>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Role</th>
      </tr>

      <tr
      v-for="(table, index) in tables"
      v-bind:item="table"
      v-bind:index="index"
      v-bind:key="table.id"
      >
      <td>{{ table.id }}</td>
      <td>{{ table.name }}</td>
      <td>{{ table.role }}</td>

      </tr>
    
    </table> -->

  </div>
  
</template>

<script>
import TestService from "../TestService";

export default {
  name: "TestComponent",
  data() {
    return {
      // Custom label for bootstrap table
      fields: [
        {
          key: 'id',
          label: 'ID'
          },
          {
            key: 'name'
          },
          {
            key: 'role',
            label: 'Dev Role'
          }
      ],

      // Data from api demo get request
      tables: [],
      error: "",
      text: "",
    };
  },
  async created() {
    try {
      this.tables = await TestService.getTable();
    } catch (err) {
      this.error = err.message;
    }
  },
};
</script>


<style scoped>
</style>
