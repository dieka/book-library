<template>
  <section class="section">
    <div class="container">
      <div class="columns is-mobile">
        <div class="column is-half is-offset-one-quarter">
          <div class="box">
            <div class="title-form" v-if="isCreateFormMode">
              Create a new Book
            </div>
            <div class="title-form" v-if="!isCreateFormMode">
              Edit a book
            </div>
            <br />
            <b-loading
              :is-full-page="true"
              :active.sync="isButtonLoading"
              :can-cancel="true"
            ></b-loading>
            <form id="formLogin" @submit="onSubmit($event)">
              <b-field horizontal label="ISBN" v-if="!isCreateFormMode">
                <b-input disabled v-model="model.isbn"></b-input>
              </b-field>
              <b-field
                horizontal
                label="Title"
                :type="{ 'is-danger': $v.model.title.$error }"
                icon-right="close-circle"
                :message="{
                  'This title is required': $v.model.title.$error
                }"
              >
                <b-input
                  name="title"
                  placeholder="Input your title"
                  v-model="model.title"
                  @input="$v.model.title.$touch"
                ></b-input>
              </b-field>

              <b-field
                horizontal
                label="Author"
                :type="{ 'is-danger': $v.model.author.$error }"
                icon-right="close-circle"
                :message="{
                  'This author is required': $v.model.author.$error
                }"
              >
                <b-input
                  name="author"
                  placeholder="Input your author"
                  v-model="model.author"
                  @input="$v.model.author.$touch"
                ></b-input>
              </b-field>

              <b-field
                horizontal
                label="Publisher Name"
                :type="{ 'is-danger': $v.model.publisher_name.$error }"
                icon-right="close-circle"
                :message="{
                  'This publisher name is required':
                    $v.model.publisher_name.$error
                }"
              >
                <b-input
                  name="publisher_name"
                  placeholder="Input your publisher name"
                  v-model="model.publisher_name"
                  @input="$v.model.publisher_name.$touch"
                ></b-input>
              </b-field>

              <b-field
                horizontal
                label="Publisher Year"
                :type="{ 'is-danger': $v.model.publisher_year.$error }"
                icon-right="close-circle"
                :message="{
                  'This publisher year is invalid':
                    $v.model.publisher_year.$error
                }"
              >
                <b-input
                  name="publisher_year"
                  type="number"
                  maxlength="4"
                  placeholder="Input your publisher year (ex: 2004)"
                  v-model="model.publisher_year"
                  @input="$v.model.publisher_year.$touch"
                ></b-input>
              </b-field>

              <b-field
                horizontal
                label="Genre"
                :type="{ 'is-danger': $v.model.genre.$error }"
                icon-right="close-circle"
                :message="{
                  'This genre is required': $v.model.genre.$error
                }"
              >
                <b-select
                  placeholder="Select a genre"
                  v-model="model.genre"
                  expanded=""
                >
                  <option
                    v-for="option in genreOptions"
                    :value="option.caption"
                    :key="option.caption"
                  >
                    {{ option.caption }}
                  </option>
                </b-select>
              </b-field>

              <b-field
                horizontal
                label="Synopsis"
                :type="{ 'is-danger': $v.model.synopsis.$error }"
                icon-right="close-circle"
                :message="{
                  'This synopsis is required': $v.model.synopsis.$error
                }"
              >
                <b-input
                  name="synopsis"
                  placeholder="Input your synopsis"
                  maxlength="200"
                  type="textarea"
                  v-model="model.synopsis"
                  @input="$v.model.synopsis.$touch"
                ></b-input>
              </b-field>

              <b-field
                horizontal
                label="Status"
                :type="{ 'is-danger': $v.model.status.$error }"
                icon-right="close-circle"
                :message="{
                  'This status is required': $v.model.status.$error
                }"
                ><div class="block">
                  <b-radio
                    v-model="model.status"
                    name="status"
                    :native-value="true"
                  >
                    Active
                  </b-radio>
                  <b-radio
                    v-model="model.status"
                    name="status"
                    :native-value="false"
                  >
                    Inactive
                  </b-radio>
                </div>
              </b-field>
              <b-field horizontal
                ><!-- Label left empty for spacing -->
                <p class="control">
                  <button type="submit" class="button is-primary">
                    Submit
                  </button>
                </p>
              </b-field>
            </form>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { required, maxLength } from "vuelidate/lib/validators";
export default {
  data() {
    return {
      genreOptions: [
        {
          caption: "Horor"
        },
        {
          caption: "Fantasi"
        },
        {
          caption: "Romance"
        },
        {
          caption: "Humor"
        },
        {
          caption: "Misteri"
        },
        {
          caption: "Biografi"
        },
        {
          caption: "Jurnal"
        },
        {
          caption: "Sejarah"
        }
      ],
      isButtonLoading: false,
      model: {
        id: null,
        isbn: "",
        title: "",
        author: "",
        publisher_name: "",
        publisher_year: "",
        genre: null,
        synopsis: "",
        status: ""
      }
    };
  },
  computed: {
    isCreateFormMode() {
      return this.$route.name === "BookAdd";
    }
  },
  validations: {
    model: {
      title: {
        required
      },
      author: {
        required
      },
      publisher_name: {
        required
      },
      publisher_year: {
        required,
        maxLength: maxLength(4)
      },
      genre: {
        required
      },
      synopsis: {
        required
      },
      status: {
        required
      }
    }
  },
  created() {
    if (!this.isCreateFormMode) {
      this.$store
        .dispatch("get", this.$route.params.id)
        .then(result => {
          console.log(result);
          this.model = result.data.data;
        })
        .catch(() => {
          console.log("error fetch data");
        });
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault();
      this.$v.$touch();
      if (this.$v.model.$invalid) {
        for (let key in Object.keys(this.$v.model)) {
          const input = Object.keys(this.$v.model)[key];
          if (input.includes("$")) return false;
          if (this.$v.model[input].$error) {
            break;
          }
        }
        return;
      }
      this.isButtonLoading = true;
      if (this.isCreateFormMode) {
        this.$store
          .dispatch("create", this.model)
          .then(result => {
            console.log(result);
            this.$router.replace({ name: "Book" });
            this.$buefy.toast.open("Book created!");
          })
          .catch(() => {
            this.isButtonLoading = false;
          });
      } else {
        this.$store
          .dispatch("update", this.model)
          .then(() => {
            this.$router.replace({ name: "Book" });
            this.$buefy.toast.open("Book updated!");
          })
          .catch(() => {
            this.isButtonLoading = false;
          });
      }
    }
  }
};
</script>

<style scoped>
.title-form {
  text-align: center;
  font-weight: bold;
  font-size: 26px;
}
</style>
