<template>
  <div class="database">
    <img alt="Vue logo" src="../assets/logo.png" />
    <h3>{{ value }}</h3>
    <VueSlider
      v-model="value"
      min="1"
      max="100"
      :marks="marks"
      drag-on-click
      :contained="true"
      lazy
    >
      <template #tooltip>
        <div>{{ value }}</div>
      </template>
    </VueSlider>
  </div>
</template>

<script>
export default {
  name: "Database",
  components: {},
  data() {
    return {
      value: 20,
      marks: [0, 18, 30, 50, 80, 100],
    };
  },
};
</script>
