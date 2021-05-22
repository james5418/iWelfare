<template>
  <b-container class="bv-example-row">
    <b-row>
      <!-- <b-col cols="1">年齡: {{ value }}</b-col> -->
      <b-col cols="12">
        <VueSlider
          min="0"
          max="100"
          :marks="[0, 20, 40, 60, 80, 100]"
          drag-on-click
          :contained="true"
          v-model="value"
          @change="$emit('input', value)"
        />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  name: "AgeSlider",
  props: {
    value: Number,
  },
  data(){
    return {
      value: 0,
    }
  }
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
