<template>
  <div class="Tag">
    <img alt="Vue logo" height="500rem" width="1500rem" src="/logo2.png" />
    <h2>名稱中含有 "{{ search_name }}" 的補助:</h2>
    <b-collapse id="collapse-t" v-model="table_visible" class="mt-2">
      <div style="right: 5rem">一共 {{ search_cnt }} 筆搜尋結果</div>
      <ReturnList :msgs="msgs" />
    </b-collapse>
  </div>
</template>

<script>
import ReturnList from "@/components/ReturnList.vue";

export default {
  name: "Name",
  components: {
    ReturnList,
  },
  created() {
    this.fetchData(this.$route.params.name);
  },
  data() {
    return {
      // Note `isActive` is left out and will not appear in the rendered table
      search_name: this.$route.params.name,
      table_visible: false,
      msgs: [],
      search_cnt: 0,
    };
  },
  methods: {
    async search_tags(wid) {
      const qstr = `SELECT t.tag_id, tag FROM ( SELECT tag_id FROM corresponding WHERE welfare_id = ${wid} ) as c INNER JOIN tags t ON t.tag_id = c.tag_id ORDER BY c.tag_id`;
      const val = await this.axios
        .post("/mysql/", {
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
    async fetchData(name) {
      const qstr = `SELECT welfare_id, name FROM overall WHERE name LIKE "%${name}%"`;
      const val = await this.axios
        .post("/mysql/", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });
      this.search_cnt = val.length;
      this.table_visible = true;

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
    },
  },
};
</script>
