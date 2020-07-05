import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import store from "../store/index";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
    meta: {
      title: "Home Page"
    }
  },
  {
    path: "/about",
    name: "About",
    meta: {
      title: "About Page"
    },
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue")
  },
  {
    path: "/login",
    name: "Login",
    meta: {
      title: "Login Page"
    },
    component: () =>
      import(/* webpackChunkName: "login" */ "../views/Login.vue")
  },
  {
    path: "/book",
    name: "Book",
    meta: {
      title: "Book Listing"
    },
    component: () =>
      import(/* webpackChunkName: "book" */ "../views/books/BookList.vue")
  },
  {
    path: "/book/create",
    name: "BookAdd",
    meta: {
      title: "Login Page"
    },
    component: () =>
      import(/* webpackChunkName: "book-add" */ "../views/books/BookForm.vue")
  },
  {
    path: "/book/edit/:id",
    name: "BookEdit",
    component: () =>
      import(/* webpackChunkName: "book-edit" */ "../views/books/BookForm.vue")
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

router.beforeEach(async (to, from, next) => {
  const nearestWithTitle = to.matched
    .slice()
    .reverse()
    .find(r => r.meta && r.meta.title);

  if (nearestWithTitle)
    document.title = nearestWithTitle.meta.title + " | B-Lib";

  if (
    to.name.trim() === "Login" ||
    to.name.trim() === "Home" ||
    to.name.trim() === "About"
  )
    return next();

  var result = await store.dispatch("tryAutoLogin");
  if (result) {
    return next();
  } else {
    store.dispatch("logout");
    return next("/login");
  }
});

export default router;
