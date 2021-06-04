<template>
  <div class="database">
    <img alt="Vue logo" src="/logo3.jpg" width="110" height="110" />
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
