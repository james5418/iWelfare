<template>
  <div class="database">
    <img alt="Vue logo" src="/logo3.png" width="120" height="120" />
    <br /><br />
    <ReformDB />
  </div>
</template>

<script>
import ReformDB from "@/components/ReformDB.vue";

export default {
  name: "Database",
  components: {
    ReformDB,
  },
  data() {
    return {
      value: 20,
    };
  },
};
</script>
