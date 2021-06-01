<template>
  <div class="text-left">
    <b-table
      text-left="true"
      :style="{ backgroundColor: '#ffffff' }"
      head-variant="dark"
      foot-variant="white"
      hover
      fixed
      striped
      :fields="fields"
      :items="msgs"
    >
      <template #cell(name)="row">
        <!-- `data.value` is the value after formatted by the Formatter -->
        <h5>
          <a :href="`/overall/${row.item.welfare_id}`">{{ row.value }}</a>
        </h5>
      </template>
      <template #cell(tags)="row">
        <li v-for="(value, key) in row.item.tags" :key="key">
          <b-button variant="info" size="sm" :href="`/tag/${value.tag_id}`">
            {{ value.tag }}
          </b-button>
        </li>
      </template>
    </b-table>
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
      fields: [
        {
          key: "name",
          label: "福利項目名稱",
        },
        {
          key: "tags",
          label: "福利項目標籤",
        },
      ],
    };
  },
  methods: {},
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

.tags-input {
  display: flex;
  flex-wrap: wrap;
  align-items: right;
}
</style>
