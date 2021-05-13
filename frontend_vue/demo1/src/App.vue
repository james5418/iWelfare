<template>
  <div id="app" align-v="center">
    <TopNavbar />
    <br />
    <br />
    <router-view />
  </div>
</template>

<script>
import TopNavbar from "./components/TopNavbar.vue";

export default {
  components: {
    TopNavbar, // register component
  },
};
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
