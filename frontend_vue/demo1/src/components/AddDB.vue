<template>
  <b-container fluid class="bv-example-row">
    <b-card
      :header="header_text"
      header-bg-variant="secondary"
      header-text-variant="light"
      bg-variant="light"
      class="text-center"
    >
      <b-card-text>
        <b-input-group prepend="相關標籤">
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
            ref="container"
            :limit="8"
          />
          <b-dropdown
            v-b-modal.new-tag
            text="選擇標籤"
            lazy
            boundary
            @click="new_tag(tag)"
          >
            <b-dropdown-item v-for="(tag, key) in tags_data" :key="key">
              <div @click="append_selected(tag)">{{ tag.tag }}</div>
            </b-dropdown-item>
          </b-dropdown>
        </b-input-group>
        <b-input-group prepend="項目名稱">
          <b-form-input
            v-model="input_name"
            placeholder="在此輸入補助項目名稱"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="補助項目">
          <b-form-input
            v-model="input_welfare"
            placeholder="在此輸入補助項目內容"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="辦理機構">
          <b-form-input
            v-model="input_apply"
            placeholder="在此輸入辦理的機構"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="聯絡方式">
          <b-form-input
            v-model="input_contact"
            placeholder="在此輸入機構聯絡方式"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="申請條件">
          <b-form-input
            v-model="input_criteria"
            placeholder="在此輸入補助申請條件"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="應備證件">
          <b-form-input
            v-model="input_doc"
            placeholder="在此輸入辦理應備證件"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="注意事項">
          <b-form-input
            v-model="input_notice"
            placeholder="其他的注意事項..."
          ></b-form-input>
        </b-input-group>
        <b-collapse id="collapse-t" v-model="age_enable" class="mt-2">
          <b-col>
            <div>年齡：</div>
            <VueSlider
              v-model="age_range"
              :min="0"
              :max="100"
              :marks="[0, 20, 40, 60, 80, 100]"
              :contained="true"
            />
          </b-col>
          <br /><br />
        </b-collapse>
        <b-form-checkbox v-model="age_enable"> 申請年齡限制 </b-form-checkbox>
        <b-button @click="process()">
          {{ button_text }}
        </b-button>
      </b-card-text>
    </b-card>
  </b-container>
</template>

<script>
export default {
  name: "AddDB",
  props: {
    mode: String,
    input_str: Object,
  },
  mounted() {
    this.fetchData();
  },
  watch: {
    input_str: "this.assignData",
  },
  created() {
    this.assignData();
  },
  data() {
    return {
      age_enable: false,
      tags_data: [],
      input_id: "",
      input_name: "",
      input_welfare: "",
      input_apply: "",
      input_contact: "",
      input_criteria: "",
      input_doc: "",
      input_notice: "",
      age_range: [0, 100],
      selectedTags: [],
      header_text: "",
      button_text: "",
      confirm_text: "",
    };
  },
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/tags/?_size=200")
        .then(function (response) {
          return response.data;
        });
      //console.log(val);
      this.tags_data = val;
    },
    assignData() {
      if (this.mode === "update") {
        this.input_id = this.input_str.input_id;
        this.input_name = this.input_str.input_name;
        this.input_welfare = this.input_str.input_welfare;
        this.input_apply = this.input_str.input_apply;
        this.input_contact = this.input_str.input_contact;
        this.input_criteria = this.input_str.input_criteria;
        this.input_doc = this.input_str.input_doc;
        this.input_notice = this.input_str.input_notice;
        this.age_range = this.input_str.age_range;
        this.selectedTags = this.input_str.selectedTags;
        this.age_enable = true;
        this.header_text = "修改此筆資料";
        this.button_text = "完成修改";
        this.confirm_text = "確認修改此項目？";
        this.success_text = "修改成功！";
      } else if (this.mode === "renew") {
        this.header_text = "重建此筆資料";
        this.button_text = "完成重建";
        this.confirm_text = "確認重建此項目？";
        this.success_text = "重建成功！";
      } else {
        this.header_text = "新增資料庫";
        this.button_text = "新增福利項目";
        this.confirm_text = "確認新增福利項目？";
        this.success_text = "新增成功！";
      }
    },
    append_selected(tag) {
      if (this.selectedTags.includes(tag)) {
        alert("請勿選擇重複的標籤！");
        return;
      }
      if (this.selectedTags.length >= 8) {
        alert("達標籤上限！");
        return;
      }
      this.selectedTags.push(tag);
      console.log(this.selectedTags);
    },
    reset_input() {
      this.input_name = "";
      this.input_welfare = "";
      this.input_apply = "";
      this.input_contact = "";
      this.input_criteria = "";
      this.input_doc = "";
      this.input_notice = "";
      this.selectedTags = [];
    },
    validate_input() {
      if (
        this.input_name === "" ||
        this.input_welfare === "" ||
        this.input_apply === "" ||
        this.input_contact === "" ||
        this.input_criteria === "" ||
        this.input_doc === "" ||
        this.input_notice === "" ||
        this.selectedTags.length === 0
      )
        return false;
      else return true;
    },
    async process() {
      if (confirm(this.confirm_text)) {
        if (!this.validate_input()) {
          alert("輸入格式有誤！");
          return;
        }
        // adding new overall to db
        if (this.mode === "update") {
          this.modify_welfare();
        } else {
          this.add_welfare();
        }
      }
    },
    async modify_welfare() {
      const mod_wid = await this.axios
        .put("/backend/overall", {
          welfare_id: this.input_id,
          name: this.input_name,
          welfare: this.input_welfare,
          application_agency: this.input_apply,
          contact_info: this.input_contact,
          criteria: this.input_criteria,
          document_needed: this.input_doc,
          notice: this.input_notice,
        })
        .then(function (response) {
          return response.data.insertId;
        });
      console.log(mod_wid);

      // adding wid age range to db
      var age_l, age_h;
      if (this.age_enable) {
        age_l = this.age_range[0];
        age_h = this.age_range[1];
      } else {
        age_l = 0;
        age_h = 100;
      }

      console.log(age_l, age_h);
      const age_msg = await this.axios
        .put("/backend/age", {
          welfare_id: this.input_id,
          age_lower: age_l,
          age_upper: age_h,
        })
        .then(function (response) {
          return response.data;
        });
      console.log(age_msg);

      // new tags to create(tag_id === "")
      var new_tag_arr = [];
      for (var i = 0; i < this.selectedTags.length; ++i) {
        if (this.selectedTags[i].tag_id === "") {
          const new_tid = await this.axios
            .post("/backend/tags", {
              tag: this.selectedTags[i].tag,
            })
            .then(function (response) {
              return response.data.insertId;
            });
          new_tag_arr.push(new_tid);
          continue;
        }
      }

      // add(tag_id not in input_str)
      for (i = 0; i < this.selectedTags.length; ++i) {
        if (this.selectedTags[i].tag_id === "") return;

        var contain = false;
        for (var j = 0; j < this.input_str.selectedTags.length; ++j) {
          if (
            this.selectedTags[i].tag_id ===
            this.input_str.selectedTags[j].tag_id
          ) {
            contain = true;
            break;
          }
        }
        if (!contain) {
          const new_tid = this.selectedTags[i].tag_id;
          new_tag_arr.push(new_tid);
        }
      }

      // adding new correspondings to db
      for (i = 0; i < new_tag_arr.length; ++i) {
        const cor_msg = await this.axios
          .post("/backend/corresponding", {
            welfare_id: this.input_id,
            tag_id: new_tag_arr[i],
          })
          .then(function (response) {
            return response.data;
          });
        console.log("added cor:");
        console.log(cor_msg);
      }

      // remove tags (input_str not selected)
      var rmv_tag_arr = [];
      for (i = 0; i < this.input_str.selectedTags.length; ++i) {
        contain = false;
        for (j = 0; j < this.selectedTags.length; ++j) {
          if (
            this.input_str.selectedTags[i].tag_id ===
            this.selectedTags[j].tag_id
          ) {
            contain = true;
            break;
          }
        }
        if (!contain) {
          const rmv_tid = this.input_str.selectedTags[i].tag_id;
          rmv_tag_arr.push(rmv_tid);
        }
      }

      //removing not used tag from tags
      for (i = 0; i < rmv_tag_arr.length; ++i) {
        const cor_cnt = await this.axios
          .get(
            `/backend/corresponding/?_where=(tag_id,eq,${rmv_tag_arr[i]})&_fields=tag_id`
          )
          .then(function (response) {
            return response.data.length;
          });
        if (cor_cnt === 1) {
          const del_msg = await this.axios
            .delete("/backend/tags/" + rmv_tag_arr[i])
            .then(function (response) {
              return response.data;
            });
          console.log(del_msg);
        }

        //removing old corresponings
        const cor_msg = await this.axios
          .delete(`/backend/corresponding/${this.input_id}___${rmv_tag_arr[i]}`)
          .then(function (response) {
            return response.data;
          });
        console.log(cor_msg);
      }

      this.reset_input();
      this.$emit("reformed");
      alert(this.success_text);
    },

    async add_welfare() {
      //add new overall, get new wid.
      const new_wid = await this.axios
        .post("/backend/overall", {
          name: this.input_name,
          welfare: this.input_welfare,
          application_agency: this.input_apply,
          contact_info: this.input_contact,
          criteria: this.input_criteria,
          document_needed: this.input_doc,
          notice: this.input_notice,
        })
        .then(function (response) {
          return response.data.insertId;
        });
      console.log(new_wid);

      // adding wid age range to db
      var age_l, age_h;
      if (this.age_enable) {
        age_l = this.age_range[0];
        age_h = this.age_range[1];
      } else {
        age_l = 0;
        age_h = 100;
      }

      const age_msg = await this.axios
        .post("/backend/age", {
          welfare_id: new_wid,
          age_lower: age_l,
          age_upper: age_h,
        })
        .then(function (response) {
          return response.data;
        });
      console.log(age_msg);

      // adding new tags to db
      var tag_arr = [];
      for (var i = 0; i < this.selectedTags.length; ++i) {
        if (this.selectedTags[i].tag_id === "") {
          const new_tid = await this.axios
            .post("/backend/tags", {
              tag: this.selectedTags[i].tag,
            })
            .then(function (response) {
              return response.data.insertId;
            });

          tag_arr.push(new_tid);
        } else {
          tag_arr.push(this.selectedTags[i].tag_id);
        }
      }

      // adding new correspondings to db
      for (i = 0; i < tag_arr.length; ++i) {
        const cor_msg = await this.axios
          .post("/backend/corresponding", {
            welfare_id: new_wid,
            tag_id: tag_arr[i],
          })
          .then(function (response) {
            return response.data;
          });
        console.log(cor_msg);
      }
      //reset input
      this.reset_input();
      this.$emit("reformed");
      alert(this.success_text);
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
