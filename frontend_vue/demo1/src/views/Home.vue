<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
    {{ value }}
    <SearchBar />
    <AgeSlider v-model="value" />
  </div>
</template>

<script>
// @ is an alias to /src
import SearchBar from "@/components/SearchBar.vue";
import AgeSlider from "@/components/AgeSlider.vue";

export default {
  name: "Home",
  components: {
    SearchBar,
    AgeSlider,
  },
  props: {},
  data() {
    return {
      value: 30,
    };
  },
};
</script>
