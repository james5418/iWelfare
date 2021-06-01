<template>
  <div>
    <b-container fluid>
      <!-- <li v-for="m in msgs" :key="m.welfare_id">
        <span @click="showMore(m)">{{ m }}</span>
      </li> -->
      <b-card bg-variant="light" img-src="/logo.png" class="text-center">
        <b-card-text>
          <tags-input
            element-id="tags"
            v-model="selectedTags"
            placeholder="在此輸入查詢標籤"
            :existing-tags="tags_data"
            only-existing-tags
            typeahead-hide-discard
            typeahead
            typeahead-style="dropdown"
            typeahead-show-on-focus
            id-field="tag_id"
            text-field="tag"
            ref="container"
            :limit="8"
          />

          <b-collapse id="collapse-a" v-model="age_visible" class="mt-2">
            <b-form-checkbox v-model="age_enable">
              啟用年齡搜尋
            </b-form-checkbox>
            <b-collapse id="collapse-t" v-model="age_enable" class="mt-2">
              <b-col>
                <div>年齡：</div>
                <VueSlider
                  v-model="age"
                  :min="0"
                  :max="100"
                  :marks="[0, 20, 40, 60, 80, 100]"
                  :contained="true"
                />
              </b-col>
              <br /><br />
            </b-collapse>
          </b-collapse>

          <b-dropdown
            text="搜尋"
            class="lg"
            lazy
            split
            boundary
            @click="search_welfare(selectedTags, age)"
          >
            <b-dropdown-item v-for="(tag, key) in tags_data" :key="key">
              <div @click="append_selected(tag)">{{ tag.tag }}</div>
            </b-dropdown-item>
          </b-dropdown>
          <b-button
            style="position: absolute; right: 1rem"
            variant="Light"
            @click="age_visible = !age_visible"
          >
            進階選項
          </b-button>
        </b-card-text>
      </b-card>

      <div>
        <b-collapse id="collapse-t" v-model="table_visible" class="mt-2">
          <div style="right: 5rem">一共 {{ search_cnt }} 筆搜尋結果</div>
          <hr />
          <ReturnList :msgs="msgs" />
        </b-collapse>
      </div>
    </b-container>
  </div>
</template>

<script>
import ReturnList from "@/components/ReturnList.vue";

export default {
  name: "SearchBar",
  components: {
    ReturnList,
  },
  created() {
    this.fetchData();
  },
  watch: {
    "$route.path": "this.fetchData",
    msgs: "scrolltoTable",
  },
  data() {
    return {
      selectedTags: [
        { tag_id: 35, tag: "孕婦" },
        { tag_id: 36, tag: "生育" },
      ],
      tags_data: [],
      age: 18,
      age_enable: false,
      age_visible: false,
      table_visible: false,
      msgs: [],
      search_cnt: 0,
    };
  },
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/tags/?_size=500")
        .then(function (response) {
          return response.data;
        });
      //console.log(val);
      this.tags_data = val;
    },
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
    async search_welfare(tags, age) {
      if (tags.length === 0) {
        alert("請輸入標籤再進行搜尋！");
        return;
      }
      //console.log(this.input_tags);
      var qstr = `SELECT o.welfare_id , name FROM ( SELECT welfare_id, COUNT(*) as cnt FROM ( `;
      if (this.age_enable)
        qstr += `SELECT welfare_id FROM age WHERE (age_lower <= ${age}) AND (age_upper >= ${age}) UNION ALL `; //age
      qstr += `SELECT welfare_id FROM corresponding WHERE `; //tag

      for (var i = 0; i < tags.length; ++i) {
        qstr += `(tag_id = "${tags[i]["tag_id"]}") `;
        if (i != tags.length - 1) qstr += "OR ";
      }
      const tag_cnt = tags.length + this.age_enable; //age + 1
      qstr += `) as x GROUP BY welfare_id HAVING cnt = ${tag_cnt} ) as y INNER JOIN overall o ON o.welfare_id = y.welfare_id`;
      //console.log(qstr);
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });

      this.search_cnt = val.length;
      this.table_visible = true;
      //console.log(val);
      var arr = [];
      for (i = 0; i < val.length; ++i) {
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

      //const element = this.$refs["container"];
      //console.log(element.$el.offsetTop);
      // setTimeout(function () {
      //   window.scrollTo({
      //     top: element.$el.offsetTop,
      //     behavior: "smooth",
      //   });
      // }, 250);
    },
    append_selected(tag) {
      if (this.selectedTags.includes(tag)) {
        alert("請勿選擇重複的標籤！");
        return;
      }
      this.selectedTags.push(tag);
    },
    scrolltoTable() {
      const element = this.$refs["container"];
      console.log(element.$el.offsetTop);
      setTimeout(function () {
        window.scrollTo({
          top: element.$el.offsetTop,
          behavior: "smooth",
        });
      });
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

.tags-input {
  display: flex;
  flex-wrap: wrap;
  align-items: right;
}
</style>
