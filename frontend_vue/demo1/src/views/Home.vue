<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
    <SearchBar />
    <b-button @click="tags_search()" />
  </div>
</template>

<script>
// @ is an alias to /src
import SearchBar from "@/components/SearchBar.vue";

export default {
  name: "Home",
  components: {
    SearchBar,
  },
  props: {},
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/age" + this.group_id + "/")
        .then(function (response) {
          return response.data;
        });
      this.group = val;
    },

    async tags_search() {
      const val = await this.axios
        .post("/mysql", {
          query:
            "SELECT welfare_id FROM ( SELECT welfare_id, COUNT(*) as cnt FROM ( SELECT welfare_id, tag FROM corresponding as c JOIN tags as t ON c.tag_id = t.tag_id )as n WHERE (n.tag = '屏東縣') OR (n.tag = '婦女') OR (n.tag = '孕婦') OR (n.tag = '生育') OR (n.tag = '中低收入戶') GROUP BY welfare_id) as x WHERE cnt = 5",
        })
        .then(function (response) {
          return response.data;
        });

      console.log(val);
    },
  },
};
</script>
