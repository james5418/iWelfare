<template>
  <b-container class="bv-example-row">
    <b-card header="change text" bg-variant="light" class="text-center">
      <b-card-text> hello </b-card-text>
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
    add_db() {
      var tag_string = "";
      this.input_tags.forEach(function (value) {
        tag_string += " " + value;
      });
      console.log(tag_string);
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
