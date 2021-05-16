<template>
  <b-container class="bv-example-row">
    <b-input-group prepend="種類">
      <b-form-input v-model="text_type" placeholder="照護"></b-form-input>
    </b-input-group>

    <b-input-group prepend="身份">
      <b-form-input v-model="text_identity" placeholder="孕婦"></b-form-input>
    </b-input-group>

    <b-input-group prepend="設籍">
      <b-form-input v-model="text_house" placeholder="台北"></b-form-input>
    </b-input-group>

    <b-input-group prepend="年齡">
      <b-form-input v-model="text_age_lb" placeholder="0"></b-form-input>
      <b-form-input v-model="text_age_hb" placeholder="100"></b-form-input>
    </b-input-group>

    <b-button squared @click="add_db()"> 新增項目 </b-button>

    <!-- <b-input-group prepend="所得">
      <b-form-input v-model="text_type" placeholder="最高年齡"></b-form-input>
    </b-input-group> -->
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
      text_type: "",
      text_identity: "",
      text_house: "",
      text_age_lb: "",
      text_age_hb: "",
    };
  },
  methods: {
    add_db() {
      const test_string =
        this.text_type +
        this.text_identity +
        this.text_house +
        this.text_age_lb +
        this.text_age_hb;
      console.log(test_string);
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
