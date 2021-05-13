<template>
  <div class="ListSearch">
    <img alt="Vue logo" src="../assets/logo.png" />
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
