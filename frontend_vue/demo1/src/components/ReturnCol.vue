<template>
  <div>
    <!-- <b-table
      :style="{ backgroundColor: '#ffffff' }"
      head-variant="dark"
      foot-variant="white"
      striped
      hover
      :fields="fields"
      :items="msgs"
    ></b-table> -->
    <b-table
      show-empty
      bordered
      striped
      hover
      :fields="fields"
      :items="w_data"
      @row-dblclicked="
        (item, index, event) =>
          rowDblClickHandler(comp.name, item, index, event)
      "
    >
    </b-table>
  </div>
</template>

<script>
export default {
  name: "ReturnList",
  props: {
    fields: Array,
    msgs: JSON,
  },
  data() {
    // return {
    //   // Note `isActive` is left out and will not appear in the rendered table
    //   w_data: [],
    //   fields: [],
    // };
  },
  methods: {
    async fetchData(tagID) {
      const val = await this.axios
        .get("/backend/overall/" + tagID)
        .then(function (response) {
          return response.data;
        });
      this.w_data = val;
      console.log("w_data");
      console.log(val);
    },
    rowDblClickHandler(name, item, index, event) {
      console.log(name, item, index, event);
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
a {
  color: #42b983;
}
.tags-input {
  display: flex;
  flex-wrap: wrap;
  align-items: right;
}
</style>
