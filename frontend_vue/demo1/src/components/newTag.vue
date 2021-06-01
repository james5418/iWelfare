<template>
  <b-container fluid class="bv-example-row">
    <b-input-group prepend="新增標籤">
      <tags-input
        element-id="tags"
        v-model="selectedTags"
        placeholder="在此輸入查詢標籤"
        :existing-tags="tags_data"
        typeahead-hide-discard
        typeahead
        typeahead-style="dropdown"
        typeahead-show-on-focus
        id-field="tag_id"
        text-field="tag"
        :limit="1"
      />
      <b-dropdown
        v-b-modal.new-tag
        text="新增標籤"
        split
        lazy
        boundary
        @click="add_welfare()"
      >
        <b-dropdown-item v-for="(tag, key) in tags_data" :key="key">
          <div @click="append_selected(tag)">{{ tag.tag }}</div>
        </b-dropdown-item>
      </b-dropdown>
    </b-input-group>
  </b-container>
</template>

<script>
export default {
  name: "newTag",
  props: {
    wid: String,
  },
  mounted() {
    this.fetchData();
  },
  data() {
    return {
      tags_data: [],
      selectedTags: [],
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
    append_selected(tag) {
      this.selectedTags = [tag];
    },
    validate_input() {
      return this.selectedTags.length === 1;
    },
    async add_welfare() {
      if (confirm("添加標籤？")) {
        if (!this.validate_input()) {
          alert("欄位不可為空！");
          return;
        }
        // adding new overall to db
        var tid = "";
        if (this.tags_data.includes(this.selectedTags)) {
          tid = this.selectedTags[0].tag_id;
        } else {
          const new_tag_id = await this.axios
            .post("/backend/tags", {
              tag: this.selectedTags[0].tag,
            })
            .then(function (response) {
              return response.data.insertId;
            });
          tid = new_tag_id;
          console.log(new_tag_id);
        }

        const cor_msg = await this.axios
          .post("/backend/corresponding", {
            welfare_id: this.wid,
            tag_id: tid,
          })
          .then(function (response) {
            return response.data;
          });
        console.log(cor_msg);
        this.$emit("reformed");
      }
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
</style>
