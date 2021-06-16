<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="dark">
      <b-navbar-brand to="/">iWelfare</b-navbar-brand>
      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item to="/">福利查詢</b-nav-item>
          <b-nav-item to="/listsearch">個人條件查詢</b-nav-item>
          <b-nav-item to="/database">完善福利資料庫</b-nav-item>
          <b-nav-item to="/about">關於</b-nav-item>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item to="/modify">編輯資料庫</b-nav-item>
          <b-nav-form>
            <b-form-input
              size="sm"
              class="mr-sm-2"
              placeholder="福利項目名稱查詢"
              v-model="input_name"
              @keydown.enter.prevent="redirect(input_name)"
            ></b-form-input>
            <b-button
              size="sm"
              class="my-2 my-sm-0"
              @click="redirect(input_name)"
              >搜尋</b-button
            >
          </b-nav-form>
          <b-nav-item-dropdown text="Lang" right>
            <b-dropdown-item href="#">EN</b-dropdown-item>
            <b-dropdown-item href="#">ES</b-dropdown-item>
            <b-dropdown-item href="#">RU</b-dropdown-item>
            <b-dropdown-item href="#">FA</b-dropdown-item>
          </b-nav-item-dropdown>

          <b-nav-item-dropdown right>
            <!-- Using 'button-content' slot -->
            <template #button-content>
              <em>User</em>
            </template>
            <b-dropdown-item href="#">Profile</b-dropdown-item>
            <b-dropdown-item href="#">Sign Out</b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: "TopNavbar",
  props: {
    msg: String,
  },
  data() {
    return {
      input_name: "",
    };
  },
  methods: {
    redirect(inpu) {
      if (inpu === "") return;
      this.$router.push({ path: `/name/${inpu}` });
    },
  },
};
</script>
