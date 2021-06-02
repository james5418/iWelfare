<template>
  <b-container fluid class="bv-example-row">
    <b-card
      header="待重建項目"
      header-bg-variant="secondary"
      bg-variant="light"
      class="text-center"
    >
      <b-table
        size="lg"
        responsive
        sticky-header="50rem"
        text-left="true"
        :style="{ backgroundColor: '#ffffff' }"
        head-variant="dark"
        foot-variant="white"
        striped
        :fields="exfields"
        :items="bonus_data"
      >
        <template #cell(reform)="row">
          <b-button size="sm" v-b-modal="'modal' + row.index">
            <b-icon icon="clipboard-plus"></b-icon>
          </b-button>
          <b-modal
            :id="'modal' + row.index"
            size="xl"
            hide-footer
            lazy
            title="重建表格"
          >
            <ReturnModal
              :fields="fields"
              :bonusLine="row.item"
              @reformed="reformed('modal' + row.index)"
            />
          </b-modal>
        </template>
      </b-table>
    </b-card>
  </b-container>
</template>

<script>
import ReturnModal from "@/components/ReformModal.vue";

export default {
  name: "ReformDB",
  components: {
    ReturnModal,
  },
  mounted() {
    this.fetchData();
  },
  watch: {
    "$route.path": "this.fetchData",
  },
  data() {
    return {
      bonus_data: [],
      fields: [],
      exfields: [],
    };
  },
  methods: {
    async fetchData() {
      const val = await this.axios
        .get("/backend/bonus/?_size=500")
        .then(function (response) {
          return response.data;
        });
      //console.log(val);
      this.bonus_data = val;
      this.fields = Object.keys(val[0]);
      this.exfields = Object.keys(val[0]);
      this.exfields.push("reform");
    },
    async reformed(id) {
      this.$bvModal.hide(id);
      await this.fetchData();
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
</style>
