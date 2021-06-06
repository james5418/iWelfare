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
          <!-- <b-form-input
            v-model="changeID"
            placeholder="請輸入要修改的welfare_id"
          ></b-form-input> -->
          <b-form-select
            v-model="changeID"
            :options="legal_welfare_id"
            value-field="welfare_id"
            text-field="text"
          >
            <template #first>
              <b-form-select-option :value="null" disabled
                >-- 選擇welfare_id --</b-form-select-option
              >
            </template>
          </b-form-select>

          <b-button variant="secondary" @click="modifyDB()">
            <b-icon icon="pencil-square"></b-icon>
          </b-button>

          <b-button variant="secondary" @click="deleteDB()">
            <b-icon icon="trash"></b-icon>
          </b-button>
        </b-input-group>
      </div>

      <b-modal ref="changedb" size="xl" hide-footer lazy title="修改資料庫">
        <AddDB
          @reformed="reformed('changedb')"
          mode="update"
          :input_str="input_str"
        />
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
    this.fetch_welfare_id();
  },
  watch: {
    "$route.path": "this.fetchData",
  },
  data() {
    return {
      changeID: null,
      welfare_data: [],
      age_data: [],
      tag_data: [],
      select_tag: [],
      input_str: {
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
      },
      deleteCorresponding: [],
      legal_welfare_id: [],
    };
  },
  methods: {
    async fetch_welfare_id() {
      var qstr = `SELECT welfare_id, name FROM overall`;
      const val = await this.axios
        .post("/mysql", {
          query: qstr,
        })
        .then(function (response) {
          return response.data;
        });
      var wid_list = [];
      for (var i = 0; i < val.length; i++) {
        wid_list.push({
          welfare_id: val[i].welfare_id,
          text: `id: ${val[i].welfare_id}   ${val[i].name}`,
        });
      }
      this.legal_welfare_id = wid_list;
    },
    async modifyDB() {
      if (this.changeID === null) {
        alert("尚未選擇項目！");
        return;
      }
      const val = await this.axios
        .get("/backend/overall/" + this.changeID)
        .then(function (response) {
          return response.data;
        });
      this.welfare_data = val;
      //console.log(this.welfare_data);
      this.input_str.input_id = this.welfare_data[0].welfare_id;
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
      this.$refs["changedb"].show();
    },
    async deleteDB() {
      if (confirm("確認刪除標籤？")) {
        if (this.changeID === null) {
          alert("尚未選擇項目！");
          return;
        }
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

        var qstr = `SELECT tag_id FROM corresponding WHERE welfare_id = ${this.changeID}`;
        const val3 = await this.axios
          .post("/mysql", {
            query: qstr,
          })
          .then(function (response) {
            return response.data;
          });

        console.log(val3);

        for (var k = 0; k < val3.length; k++) {
          const val4 = await this.axios
            .delete(
              "/backend/corresponding/" +
                this.changeID +
                "___" +
                val3[k]["tag_id"]
            )
            .then(function (response) {
              return response.data;
            });
          console.log(val4);
        }
        alert("已刪除 welfare_id = " + this.changeID);
        this.fetch_welfare_id();
      }
    },
    async reformed() {
      this.fetch_welfare_id();
      this.$refs["changedb"].hide();
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
