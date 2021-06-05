<template>
  <b-container fluid class="bv-example-row">
    <AddDB mode="renew" @reformed="reformed()" />
    <b-table
      size="lg"
      responsive
      sticky-header="20rem"
      text-left="true"
      :style="{ backgroundColor: '#ffffff' }"
      head-variant="dark"
      foot-variant="white"
      striped
      :fields="fields"
      :items="[bonusLine]"
    >
    </b-table>
  </b-container>
</template>

<script>
import AddDB from "@/components/AddDB.vue";

export default {
  components: {
    AddDB,
  },
  name: "ReformModal",
  props: {
    fields: Array,
    bonusLine: Object,
  },
  data() {
    return {
      input_text: "",
    };
  },
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/bonus/?_size=500")
        .then(function (response) {
          return response.data;
        });
      //console.log(val);
      this.bonus_data = val;
      this.fields = Object.keys(val[0]);
    },
    async delBonus(id) {
      console.log("delete " + id);
      const del_msg = await this.axios
        .delete("/backend/bonus/" + id)
        .then(function (response) {
          return response.data;
        });
      console.log("delete msg" + del_msg);
    },
    async reformed() {
      await this.delBonus(this.bonusLine.id);
      this.$emit("reformed");
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
</style>
