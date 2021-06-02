<template>
  <div id="app" align-v="center">
    <TopNavbar />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/@voerro/vue-tagsinput@2.7.1/dist/style.css"
    />
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
@import ".//assets/styles/custom.scss";
@import "../node_modules/bootstrap/scss/bootstrap.scss";

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

body, html {
  padding: 0;
  margin: 0;
  width: 100%;
  min-height: 100vh;
}
body {
  background-color: white;
}
</style>
