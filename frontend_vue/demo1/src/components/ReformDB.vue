<template>
  <div>
    <p>hello, I'm search list interface</p>
  </div>
</template>

<script>
export default {
  name: "SearchButtons",
  props: {
    msg: String,
  },
  data() {
    return {
      input_tags: ["風災", "住宅", "台中"],
    };
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
