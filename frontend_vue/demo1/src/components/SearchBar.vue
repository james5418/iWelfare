<template>
  <div>
    <!-- <label for="tags-basic"></label> -->
    <b-input-group prepend="輸入條件">
      <b-form-tags input-id="tags-basic" v-model="input_tags" />
      <template #append>
        <b-button @click="search_tag()"> 搜尋 </b-button>
      </template>
    </b-input-group>

    <p class="mt-2">Input_tags: {{ input_tags }}</p>
    <div>
      <b-button
        :class="visible ? null : 'collapsed'"
        :aria-expanded="visible ? 'true' : 'false'"
        aria-controls="collapse-4"
        @click="visible = !visible"
      >
        Toggle Collapse
      </b-button>
      <b-collapse id="collapse-4" v-model="visible" class="mt-2">
        <VueSlider
          v-model="age"
          :min="0"
          :max="100"
          :marks="[0, 20, 40, 60, 80, 100]"
          :contained="true"
        />
      </b-collapse>
    </div>
  </div>
</template>

<script>
export default {
  name: "SearchBar",
  props: {
    msg: String,
  },
  data() {
    return {
      input_tags: ["風災", "住宅", "台中"],
      age: 18,
      visible: true,
    };
  },
  methods: {
    search_tag() {
      console.log(this.input_tags);
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
