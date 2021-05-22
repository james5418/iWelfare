<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
    {{ value }}
    <SearchBar />
    <VueSlider
      v-model="age"
      :min="0"
      :max="100"
      :marks="[0, 20, 40, 60, 80, 100]"
      :contained="true"
    />
  </div>
</template>

<script>
// @ is an alias to /src
import SearchBar from "@/components/SearchBar.vue";

export default {
  name: "Home",
  components: {
    SearchBar,
  },
  props: {},
  data() {
    return {
      age: 18,
    };
  },
};
</script>
