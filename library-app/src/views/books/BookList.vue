<template>
  <section class="section">
    <div class="container">
      <h1 class="title">Book Listing</h1>
      <h2 class="subtitle">
        Book management to create / update / delete book collections.
      </h2>
      <b-field>
        <b-input
          placeholder="Search..."
          type="search"
          icon="magnify"
          v-model="searchedText"
        >
        </b-input>
      </b-field>
      <b-loading
        :is-full-page="true"
        :active.sync="isLoadingData"
        :can-cancel="true"
      ></b-loading>
      <table class="table" style="width: 100%;">
        <thead>
          <tr>
            <th v-for="item in columns" :key="item.field">{{ item.label }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in booksData.data" :key="item.id">
            <td>{{ booksData.currentPage * 10 - 9 + index }}</td>
            <td>{{ item.isbn }}</td>
            <td>{{ item.title }}</td>
            <td>{{ item.author }}</td>
            <td>{{ item.genre }}</td>
            <td>
              <span class="tag is-success" v-if="item.status">Active</span>
              <span class="tag is-danger" v-if="!item.status">Inactive</span>
            </td>
            <td>
              <router-link
                class="button"
                :to="{ name: 'BookEdit', params: { id: item.id } }"
                >Edit</router-link
              >
              <button
                @click="onDelete(item.id)"
                class="button"
                style="margin-left: 10px"
              >
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
      <nav
        class="pagination is-rounded"
        role="navigation"
        aria-label="pagination"
      >
        <a
          class="pagination-previous"
          :disabled="booksData.currentPage === 1"
          @click="previousPage()"
          >Previous</a
        >
        <a
          class="pagination-next"
          :disabled="booksData.currentPage === booksData.lastPage"
          @click="nextPage()"
          >Next page</a
        >
        <ul class="pagination-list">
          <li v-for="item in booksData.lastPage" :key="item">
            <a
              class="pagination-link is_current"
              :class="{ 'is-current': item === booksData.currentPage }"
              :aria-label="'Goto page' + item"
              aria-current="page"
              @click="updatePage(item)"
              >{{ item }}</a
            >
          </li>
        </ul>
      </nav>
    </div>
  </section>
</template>

<script>
import _ from "lodash";
export default {
  data() {
    return {
      isLoadingData: false,
      searchedText: "",
      columns: [
        {
          field: "",
          label: "No"
        },
        {
          field: "isbn",
          label: "ISBN"
        },
        {
          field: "title",
          label: "Title"
        },
        {
          field: "author",
          label: "Author"
        },
        {
          field: "genre",
          label: "Genre"
        },
        {
          field: "status",
          label: "Status"
        },
        {
          field: "id",
          label: "Action"
        }
      ]
    };
  },
  watch: {
    searchedText: _.debounce(function(newValue) {
      this.fetchData(newValue, 1);
    }, 500)
  },
  computed: {
    booksData() {
      return this.$store.state.moduleBooks;
    }
  },
  mounted() {
    this.fetchData(this.searchedText, this.booksData.currentPage);
  },
  methods: {
    fetchData(searchedText, newPage) {
      this.isLoadingData = true;
      this.$store
        .dispatch("fetchData", {
          searchedText: searchedText,
          perPage: 10,
          currentPage: newPage
        })
        .then(() => {
          this.isLoadingData = false;
        });
    },
    nextPage() {
      this.isLoadingData = true;
      this.$store.dispatch("nextPage").then(() => {
        this.isLoadingData = false;
      });
    },
    previousPage() {
      this.isLoadingData = true;
      this.$store.dispatch("previousPage").then(() => {
        this.isLoadingData = false;
      });
    },
    updatePage(page) {
      this.isLoadingData = true;
      this.$store.dispatch("updatePage", page).then(() => {
        this.isLoadingData = false;
      });
    },
    onDelete(id) {
      this.$buefy.dialog.confirm({
        title: "Deleting book",
        message:
          "Are you sure you want to <b>delete</b> your book? This action cannot be undone.",
        confirmText: "Delete Book",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => {
          this.isLoadingData = true;
          this.$store.dispatch("delete", id).then(() => {
            this.isLoadingData = false;
            this.$buefy.toast.open("Book deleted!");
          });
        }
      });
    }
  }
};
</script>
