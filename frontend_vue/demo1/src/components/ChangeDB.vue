<template>
  <b-container fluid class="bv-example-row">
    <b-card
      header="修改資料庫內容"
      header-bg-variant="secondary"
      header-text-variant="light"
      bg-variant="light"
      class="text-center"
    >
      <div>
        <b-input-group prepend="welfare_id">
          <b-form-input
            v-model="changeID"
            placeholder="請輸入要修改的welfare_id"
          ></b-form-input>

          <b-button variant="secondary" v-b-modal.changedb @click="fetchData()">
            <b-icon icon="pencil-square"></b-icon>
          </b-button>

          <b-button variant="secondary" @click="deleteDB()">
            <b-icon icon="trash"></b-icon>
          </b-button>
        </b-input-group>
      </div>

      <b-modal id="changedb" size="xl" hide-footer lazy title="修改">
        <AddDB mode="update" :input_str="input_str" />
      </b-modal>
    </b-card>
  </b-container>
</template>

<script>
import AddDB from "@/components/AddDB.vue";
export default {
  name: "ChangeDB",
  components: {
    AddDB,
  },
  created() {
    // this.fetchData();
  },
  watch: {
    "$route.path": "this.fetchData",
  },
  data() {
    return {
      changeID: "",
      welfare_data: [],
      age_data: [],
      tag_data: [],
      select_tag: [],
      input_str: {
        input_name: "",
        input_welfare: "",
        input_apply: "",
        input_contact: "",
        input_criteria: "",
        input_doc: "",
        input_notice: "",
        age_range: [0, 100],
        selectedTags: [],
      },
    };
  },
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/overall/" + this.changeID)
        .then(function (response) {
          return response.data;
        });
      this.welfare_data = val;
      //console.log(this.welfare_data);
      this.input_str.input_name = this.welfare_data[0].name;
      this.input_str.input_welfare = this.welfare_data[0].welfare;
      this.input_str.input_apply = this.welfare_data[0].application_agency;
      this.input_str.input_contact = this.welfare_data[0].contact_info;
      this.input_str.input_criteria = this.welfare_data[0].criteria;
      this.input_str.input_doc = this.welfare_data[0].document_needed;
      this.input_str.input_notice = this.welfare_data[0].notice;
      //console.log(this.input_str);
      const val2 = await this.axios
        .get("/backend/age/" + this.changeID)
        .then(function (response) {
          return response.data;
        });
      this.age_data = val2;
      //console.log(this.age_data);
      this.input_str.age_range[0] = this.age_data[0].age_lower;
      this.input_str.age_range[1] = this.age_data[0].age_upper;
      //console.log(this.input_str)
      var qstr = `SELECT c.tag_id, t.tag FROM corresponding c, tags t WHERE c.welfare_id = ${this.changeID} and c.tag_id = t.tag_id `;
      const val3 = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });
      this.input_str.selectedTags = val3;
      console.log(this.input_str);
    },
    async deleteDB() {
      const val = await this.axios
        .delete("/backend/overall/" + this.changeID)
        .then(function (response) {
          return response.data;
        });
      console.log(val);
      const val2 = await this.axios
        .delete("/backend/age/" + this.changeID)
        .then(function (response) {
          return response.data;
        });
      console.log(val2);
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