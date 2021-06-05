<template>
  <div class="modify">
    <!-- <img alt="Vue logo" src="/logo.png" /> -->
    <!-- <img alt="Vue logo" src="../assets/logo.png" /> -->
    <img alt="Vue logo" src="/logo3.jpg" width="110" height="110" />
    <br /><br />
    <ChangeTag />
    <br />
    <ChangeDB />
    <br />
    <AddDB />
  </div>
</template>

<script>
// @ is an alias to /src
import ChangeTag from "@/components/ChangeTag.vue";
import ChangeDB from "@/components/ChangeDB.vue";
import AddDB from "@/components/AddDB.vue";

export default {
  name: "Modify",
  components: {
    ChangeTag,
    ChangeDB,
    AddDB,
  },
  props: {},
  methods: {},
};
</script>
