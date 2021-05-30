<template>
  <b-container class="bv-example-row">
    <h3>add database</h3>
    <b-input-group prepend="名稱">
      <b-form-input
        v-model="input_name"
        placeholder="企業相關補助項目XXX..."
      ></b-form-input>
    </b-input-group>

    <b-input-group prepend="內容">
      <b-form-input
        v-model="input_text"
        placeholder="bla bla bla bla bla bla bla bla"
      ></b-form-input>
    </b-input-group>

    <b-input-group prepend="年齡">
      <b-form-input v-model="input_age_lb" placeholder="0"></b-form-input>
      <b-form-input v-model="input_age_hb" placeholder="100"></b-form-input>
    </b-input-group>

    <b-input-group prepend="輸入條件">
      <b-form-tags input-id="tags-basic" v-model="input_tags" />
      <template #append>
        <b-button @click="add_db()"> 新增項目 </b-button>
      </template>
    </b-input-group>
  </b-container>
</template>

<script>
export default {
  name: "AddDB",
  props: {
    msg: String,
  },
  data() {
    return {
      input_name: "",
      input_text: "",
      input_age_lb: "",
      input_age_hb: "",
      input_tags: [],
    };
  },
  methods: {
    add_db() {
      var tag_string = "";
      this.input_tags.forEach(function (value) {
        tag_string += " " + value;
      });
      console.log(tag_string);
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
</style>
