<template>
  <div class="modify">
    <!-- <img alt="Vue logo" src="/logo.png" /> -->
    <!-- <img alt="Vue logo" src="../assets/logo.png" /> -->
    <ChangeDB />
  </div>
</template>

<script>
// @ is an alias to /src
import ChangeDB from "@/components/ChangeDB.vue";

export default {
  name: "Modify",
  components: {
    ChangeDB,
  },
  props: {},
  methods: {},
};
</script>
