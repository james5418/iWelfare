<template>
  <div class="database">
    <img alt="Vue logo" src="../assets/logo.png" />
    <ReformDB />
    <AddDB />
    <ChangeTag />
  </div>
</template>

<script>
import AddDB from "@/components/AddDB.vue";
import ReformDB from "@/components/ReformDB.vue";
import ChangeTag from "@/components/ChangeTag.vue";

export default {
  name: "Database",
  components: {
    AddDB,
    ReformDB,
    ChangeTag,
  },
  data() {
    return {
      value: 20,
    };
  },
};
</script>
