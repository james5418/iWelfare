<template>
  <div class="ListSearch">
    <!-- <img alt="Vue logo" src="/favicon.ico" /> -->
    <img alt="Vue logo" src="/logo3.png" width="120" height="120" />
    <br /><br />
    <h1>個人條件查詢</h1>
    <SelectButtons />
  </div>
</template>

<script>
// @ is an alias to /src
import SelectButtons from "@/components/SelectButtons.vue";
export default {
  name: "ListSearch",
  components: {
    SelectButtons,
  },
};
</script>
