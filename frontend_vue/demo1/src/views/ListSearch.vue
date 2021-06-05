<template>
  <div class="ListSearch">
    <!-- <img alt="Vue logo" src="/favicon.ico" /> -->
    <img alt="Vue logo" src="/logo3.jpg" width="110" height="110" />
    <br /><br />
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
