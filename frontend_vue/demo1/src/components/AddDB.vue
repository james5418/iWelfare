<template>
  <b-container class="bv-example-row">
    <b-card header="新增資料庫" bg-variant="light" class="text-center">
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
            placeholder="企業相關補助項目XXX..."
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="補助項目">
          <b-form-input
            v-model="input_welfare"
            placeholder="bla bla bla bla bla bla bla bla"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="辦理機構">
          <b-form-input
            v-model="input_apply"
            placeholder="bla bla bla bla bla bla bla bla"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="聯絡方式">
          <b-form-input
            v-model="input_contact"
            placeholder="bla bla bla bla bla bla bla bla"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="申請條件">
          <b-form-input
            v-model="input_criteria"
            placeholder="bla bla bla bla bla bla bla bla"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="應備證件">
          <b-form-input
            v-model="input_doc"
            placeholder="bla bla bla bla bla bla bla bla"
          ></b-form-input>
        </b-input-group>
        <b-input-group prepend="注意事項">
          <b-form-input
            v-model="input_notice"
            placeholder="bla bla bla bla bla bla bla bla"
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
        <b-button @click="add_welfare()"> 新增福利項目 </b-button>
      </b-card-text>
    </b-card>
  </b-container>
</template>

<script>
export default {
  name: "AddDB",
  props: {
    msg: String,
  },
  mounted() {
    this.fetchData();
  },
  watch: {
    "$route.path": "this.fetchData",
  },
  data() {
    return {
      age_enable: false,
      tags_data: [],
      input_name: "",
      input_welfare: "",
      input_apply: "",
      input_contact: "",
      input_criteria: "",
      input_doc: "",
      input_notice: "",
      age_range: [0, 100],
      selectedTags: [],
      new_name: "",
      nameState: null,
      invalid_text: "",
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
    async add_welfare() {
      if (confirm("確認新增福利項目？")) {
        if (!this.validate_input()) {
          alert("輸入格式有誤！");
          return;
        }
        // adding new overall to db
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
          age_l = -1;
          age_h = 127;
        }
        console.log(age_l, age_h);
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
          var contain = false;
          for (var j = 0; j < this.tags_data.length; ++j) {
            if (this.tags_data[j].tag === this.selectedTags[i].tag) {
              contain = true;
              break;
            }
          }
          if (contain) {
            tag_arr.push(this.selectedTags[i].tag_id);
          } else {
            const new_tid = await this.axios
              .post("/backend/tags", {
                tag: this.selectedTags[i].tag,
              })
              .then(function (response) {
                return response.data.insertId;
              });
            tag_arr.push(new_tid);
          }
        }
        console.log(tag_arr);
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
