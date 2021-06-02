<template>
  <b-container fluid class="bv-example-row">
    <b-card
      header="更改標籤名稱"
      header-bg-variant="secondary"
      bg-variant="light"
      class="text-center"
    >
      <b-card-text>
        <b-row>
          <b-col fluid cols="4">
            <b-input-group prepend="更改標籤">
              <b-form-select
                v-model="selected"
                :options="tags_data"
                value-field="tag_id"
                text-field="tag"
              >
                <template #first>
                  <b-form-select-option :value="null" disabled
                    >-- 選擇要更改的標籤 --</b-form-select-option
                  >
                </template>
              </b-form-select>
            </b-input-group>
          </b-col>
          <b-col cols="8">
            <b-input-group>
              <b-form-input
                v-model="input_name"
                placeholder="bla bla bla bla bla bla bla bla"
              ></b-form-input>
              <b-button @click="change_tag(input_name)"> 更改 </b-button>
            </b-input-group>
          </b-col>
        </b-row>
      </b-card-text>
    </b-card>
  </b-container>
</template>

<script>
export default {
  name: "ChangeTag",
  props: {
    msg: String,
  },
  mounted() {
    this.fetchData();
  },
  watch: {
    "$route.path": "this.fetchData", //value-field
  },
  data() {
    return {
      selected: null,
      tags_data: [],
      input_name: "",
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

    reset_input() {
      this.input_name = "";
    },

    async change_tag(tag_name) {
      if (confirm("確認修改標籤名稱？")) {
        if (this.input_name === "") {
          alert("輸入不可為空！");
          return;
        }
        const tag_msg = await this.axios
          .put("/backend/tags", {
            tag_id: this.selected,
            tag: tag_name,
          })
          .then(function (response) {
            return response.data;
          });
        console.log(tag_msg);
        //reset input
        this.reset_input();
        await this.fetchData();
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
