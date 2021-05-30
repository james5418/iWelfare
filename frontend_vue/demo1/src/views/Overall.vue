<template>
  <div class="Overall">
    <div class="text-left">
      <b-container fluid>
        <b-table
          size="lg"
          thead-class="d-none"
          fixed
          responsive
          text-left="true"
          :style="{ backgroundColor: '#ffffff' }"
          head-variant="dark"
          foot-variant="white"
          striped
          :fields="fields"
          :items="w_data"
        >
          <template #table-colgroup="scope">
            <col
              v-for="field in scope.fields"
              :key="field.key"
              :style="{ width: field.key === 'name' ? '0.8rem' : '10rem' }"
            />
          </template>

          <template #cell(value)="row">
            <div v-if="row.index === 1">
              <li v-for="(value, key) in row.item.value" :key="key">
                <b-button
                  variant="info"
                  size="sm"
                  @click="tag_query(value.tag_id)"
                >
                  {{ value.tag }}
                </b-button>
              </li>
            </div>
            <div v-else>{{ row.item.value }}</div>
          </template>
        </b-table>
      </b-container>
    </div>
  </div>
</template>

<script>
export default {
  name: "Overall",
  mounted() {
    this.fetchData(this.wid);
  },
  data() {
    return {
      wid: this.$route.params.id,
      w_data: [],
      fields: [
        {
          key: "name",
          variant: "danger",
          class: "text-right",
        },
        {
          key: "value",
        },
      ],
    };
  },
  methods: {
    async search_tags(wid) {
      const qstr = `SELECT t.tag_id, tag FROM ( SELECT tag_id FROM corresponding WHERE welfare_id = ${wid} ) as c INNER JOIN tags t ON t.tag_id = c.tag_id ORDER BY c.tag_id`;
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });
      return val;
    },
    async fetchData(wid) {
      const val = await this.axios
        .get("/backend/overall/" + wid)
        .then(function (response) {
          return response.data;
        });
      const got_tags = await this.search_tags(val[0]["welfare_id"]);

      var arr = [];
      arr.push({ name: "福利項目名稱", value: val[0]["name"] });
      arr.push({ name: "相關標籤", value: got_tags });
      arr.push({ name: "補助項目", value: val[0]["welfare"] });
      arr.push({ name: "辦理機構", value: val[0]["application_agency"] });
      arr.push({ name: "聯絡方式", value: val[0]["contact_info"] });
      arr.push({ name: "申請條件", value: val[0]["criteria"] });
      arr.push({ name: "辦理應備證件", value: val[0]["document_needed"] });
      arr.push({ name: "注意事項", value: val[0]["notice"] });
      this.w_data = arr;
    },
  },
};
</script>

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
