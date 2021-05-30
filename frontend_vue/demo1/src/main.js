import "@babel/polyfill";
import "mutationobserver-shim";
import Vue from "vue";
import "./plugins/bootstrap-vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

Vue.config.productionTip = false;

import VueSlider from "vue-slider-component";
import "vue-slider-component/theme/default.css";
Vue.component("VueSlider", VueSlider);

import VoerroTagsInput from "@voerro/vue-tagsinput";
Vue.component("tags-input", VoerroTagsInput);

import axios from "axios";
import VueAxios from "vue-axios";
Vue.use(VueAxios, axios);

import { BootstrapVueIcons } from 'bootstrap-vue'
Vue.use(BootstrapVueIcons)

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
