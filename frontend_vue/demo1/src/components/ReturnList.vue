<template>
  <div>
    <b-table
      :style="{ backgroundColor: '#ffffff' }"
      head-variant="dark"
      foot-variant="white"
      striped
      hover
      :fields="fields"
      :items="msgs"
    ></b-table>
  </div>
</template>

<script>
export default {
  name: "ReturnList",
  props: {
    msgs: Array,
  },
  data() {
    return {
      // Note `isActive` is left out and will not appear in the rendered table
      fields: [
        {
          key: "welfare_id",
          sortable: true,
        },
        {
          key: "name",
          sortable: true,
        },
        {
          key: "tags",
          sortable: true,
        },
      ],
    };
  },
  methods: {
    async gotList(msgs) {
      const keys = msgs.keys();
      console.log(keys);
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
