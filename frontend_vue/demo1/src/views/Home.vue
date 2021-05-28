<template>
  <div class="home">
    <!-- <img alt="Vue logo" src="../assets/logo.png" /> -->
    <SearchBar />
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
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/age" + this.group_id + "/")
        .then(function (response) {
          return response.data;
        });
      this.group = val;
    },
  },
};
</script>
