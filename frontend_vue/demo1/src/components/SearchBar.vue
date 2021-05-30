<template>
  <div>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@voerro/vue-tagsinput@2.7.1/dist/style.css"
    />
    <ReturnList :msgs="msgs" />
    <li v-for="m in msgs" :key="m.welfare_id">
      <span @click="showMore(m)">{{ m }}</span>
    </li>
    <tags-input
      element-id="tags"
      v-model="selectedTags"
      placeholder="enter here"
      :existing-tags="tags_data"
      only-existing-tags
      typeahead-hide-discard
      typeahead
      typeahead-style="dropdown"
      typeahead-show-on-focus
      id-field="tag_id"
      text-field="tag"
      :limit="10"
    />

    <b-button @click="search_welfare(selectedTags, age)"> 搜尋 </b-button>

    <p class="mt-2">Input_tags: {{ selectedTags }}</p>
    <div>
      <b-button
        :class="visible ? null : 'collapsed'"
        :aria-expanded="visible ? 'true' : 'false'"
        aria-controls="collapse-4"
        @click="visible = !visible"
      >
        Toggle Collapse
      </b-button>
      <b-collapse id="collapse-4" v-model="visible" class="mt-2">
        <VueSlider
          v-model="age"
          :min="0"
          :max="100"
          :marks="[0, 20, 40, 60, 80, 100]"
          :contained="true"
        />
      </b-collapse>
    </div>
  </div>
</template>

<script>
import ReturnList from "@/components/ReturnList.vue";

export default {
  name: "SearchBar",
  components: {
    ReturnList,
  },
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      selectedTags: [
        { tag_id: 36, tag: "生育" },
        { tag_id: 35, tag: "孕婦" },
        { tag_id: 21, tag: "中低收入戶" },
      ],
      tags_data: [],
      age: 18,
      visible: true,
      msgs: [],
    };
  },
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/tags/?_size=100")
        .then(function (response) {
          return response.data;
        });
      //console.log(val);
      this.tags_data = val;
    },
    async search_tag(wid) {
      const qstr = `SELECT tag FROM ( SELECT tag_id FROM corresponding WHERE welfare_id = ${wid} ) as c INNER JOIN tags t ON t.tag_id = c.tag_id`;
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });
      var tag_arr = [];
      for (var i = 0; i < val.length; ++i) {
        tag_arr.push(val[i]["tag"]);
      }
      console.log(tag_arr);
      return tag_arr;
    },
    async search_welfare(tags, age) {
      //console.log(this.input_tags);
      var qstr = `SELECT o.welfare_id , name FROM ( SELECT welfare_id, COUNT(*) as cnt FROM ( `;
      qstr += `SELECT welfare_id FROM age WHERE (age_lower <= ${age}) AND (age_upper >= ${age}) UNION ALL `; //age
      qstr += `SELECT welfare_id FROM corresponding as c JOIN tags as t ON c.tag_id = t.tag_id WHERE `; //tag

      for (var i = 0; i < tags.length; ++i) {
        qstr += `(tag = "${tags[i]["tag"]}") `;
        if (i != tags.length - 1) qstr += "OR ";
      }
      const tag_cnt = tags.length + 1; //age + 1
      qstr += `) as x GROUP BY welfare_id HAVING cnt = ${tag_cnt} ) as y INNER JOIN overall o ON o.welfare_id = y.welfare_id`;
      //console.log(qstr);
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });

      //console.log(val);
      var arr = [];
      for (i = 0; i < val.length; ++i) {
        var got_tags = await this.search_tag(val[i]["welfare_id"]);
        console.log(got_tags);
        arr.push({
          welfare_id: val[i]["welfare_id"],
          name: val[i]["name"],
          tags: got_tags,
        });
      }
      console.log(arr);
      this.msgs = arr;
      //console.log(this.fields);
    },
    showMore(m) {
      console.log(m);
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
