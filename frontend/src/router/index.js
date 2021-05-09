import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import Test from '../views/Test.vue'
import Dashboard from '../views/Dashboard.vue'
import store from '../store'

Vue.use(VueRouter)

const ifNotAuthenticated = (to, from, next) => {
    if(!store.getters.isAuthenticated){
      next()
      return
    }
    next('/')
}

const ifAuthenticated = (to, from, next) => {
  if(store.getters.isAuthenticated){
    next()
    return
  }
  next('/login')
}

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
    beforeEnter: ifNotAuthenticated,
  },
  {
    path: '/register',
    name: 'Register',
    component: Register,
    beforeEnter: ifNotAuthenticated,
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
    beforeEnter: ifAuthenticated,
  },

  {
    path: '/test',
    name: 'Test',
    component: Test
  },
  {
    path: '/about',
    name: 'About',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
  }
]

//!!!!!!!!!!!!!!!!!!!!!
// https://blog.sqreen.com/authentication-best-practices-vue/
// https://github.com/sqreen/vue-authentication-example/blob/master/src/store/index.js

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
