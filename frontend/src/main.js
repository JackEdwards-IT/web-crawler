import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from "./store"

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import '../app.scss'


// Make BootstrapVue available throughout your project
Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)

Vue.config.productionTip = false

// API address
Vue.prototype.$api = (Vue.config.productionTip) ? 'https://hostname' : 'http://localhost:3001/'

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
