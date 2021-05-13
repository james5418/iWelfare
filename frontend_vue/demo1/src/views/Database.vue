<template>
  <div class="database">
    <img alt="Vue logo" src="../assets/logo.png" />
    <VueSlider v-model="value" min="1" max="100" lazy />
    <h3>{{ value }}</h3>
  </div>
</template>

<script>
export default {
  name: "Database",
  components: {},
  data() {
    return {
      value: 20,
    };
  },
};
</script>
