<template>
  <div class="Tag">
    <img alt="Vue logo" src="../assets/logo.png" />
    <div>Tag {{ $route.params.id }}</div>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: "Tag",
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      // Note `isActive` is left out and will not appear in the rendered table
      tid: this.$route.params.id,
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
