<template>
  <div class="Tag">
    <img alt="Vue logo" src="../assets/logo.png" />
    <h2>與標籤 "{{ tag_name }}" 相關的補助: </h2>
    <b-collapse id="collapse-t" v-model="table_visible" class="mt-2">
      <div style="right: 5rem">一共 {{ search_cnt }} 筆搜尋結果</div>
      <ReturnList :msgs="msgs" />
    </b-collapse>
  </div>
</template>

<script>
import ReturnList from "@/components/ReturnList.vue";

export default {
  name: "Tag",
  components: {
    ReturnList,
  },
  created() {
    this.fetchData(this.$route.params.id);
  },
  data() {
    return {
      // Note `isActive` is left out and will not appear in the rendered table
      tid: this.$route.params.id,
      tag_name: "",
      table_visible: false,
      msgs: [],
      search_cnt: 0,
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
      // var tag_arr = [];
      // for (var i = 0; i < val.length; ++i) {
      //   tag_arr.push(val[i]["tag"]);
      // }
      //console.log(tag_arr);
      return val;
    },
    async fetchData(tid) {
      //console.log(this.input_tags);
      const val_tag = await this.axios
        .get("/backend/tags/" + tid)
        .then(function (response) {
          return response.data;
        });
      this.tag_name = val_tag[0]["tag"];

      var qstr = `SELECT o.welfare_id, name FROM ( SELECT welfare_id FROM corresponding as c JOIN tags as t ON c.tag_id = t.tag_id WHERE tag = "${this.tag_name}" GROUP BY welfare_id) as x INNER JOIN overall o ON o.welfare_id = x.welfare_id`;
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });

      console.log(val);
      var arr = [];
      for (var i = 0; i < val.length; ++i) {
        const got_tags = await this.search_tags(val[i]["welfare_id"]);
        //console.log(got_tags);
        arr.push({
          welfare_id: val[i]["welfare_id"],
          name: val[i]["name"],
          tags: got_tags,
        });
      }
      //console.log(arr);
      this.msgs = arr;
      this.search_cnt = arr.length;
      this.table_visible = true;
    },
  },
};
</script>
