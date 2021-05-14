<template>
  <div class="database">
    <img alt="Vue logo" src="../assets/logo.png" />

    <AddDB />
    <ReformDB />
  </div>
</template>

<script>
import AddDB from "@/components/AddDB.vue";
import ReformDB from "@/components/ReformDB.vue";

export default {
  name: "Database",
  components: {
    AddDB,
    ReformDB,
  },
  data() {
    return {
      value: 20,
    };
  },
};
</script>
