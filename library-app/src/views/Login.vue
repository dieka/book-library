<template>
  <section class="hero is-primary is-fullheight-with-navbar">
    <div class="hero-body">
      <div class="container">
        <div class="columns is-mobile">
          <div class="column is-half is-offset-one-quarter">
            <b-loading
              :is-full-page="true"
              :active.sync="buttonLoading"
              :can-cancel="true"
            ></b-loading>
            <div class="box">
              <div
                style="text-align: center; font-weight: bold; font-size: 26px"
              >
                Login Page
              </div>
              <br />
              <form id="formLogin" @submit="onSubmit($event)">
                <b-field
                  horizontal
                  label="Username"
                  :type="{ 'is-danger': $v.model.username.$error }"
                  icon-right="close-circle"
                  :message="{
                    'This username is required': $v.model.username.$error
                  }"
                >
                  <b-input
                    name="username"
                    placeholder="Input your username"
                    v-model="model.username"
                    @input="$v.model.username.$touch"
                  ></b-input>
                </b-field>

                <b-field
                  horizontal
                  label="Password"
                  :type="{ 'is-danger': $v.model.password.$error }"
                  icon-right="close-circle"
                  :message="{
                    'This password is required': $v.model.password.$error
                  }"
                >
                  <b-input
                    name="password"
                    type="password"
                    placeholder="Input your password"
                    v-model="model.password"
                    @input="$v.model.password.$touch"
                  ></b-input>
                </b-field>

                <b-field horizontal
                  ><!-- Label left empty for spacing -->
                  <p class="control">
                    <button type="submit" class="button is-primary">
                      Sign In
                    </button>
                  </p>
                </b-field>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { required } from "vuelidate/lib/validators";
export default {
  data() {
    return {
      model: {
        username: "",
        password: ""
      },
      showErrorMessage: false,
      errorMessage: "",
      buttonLoading: false
    };
  },
  validations: {
    model: {
      username: {
        required
      },
      password: {
        required
      }
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
      this.buttonLoading = true;
      this.$store
        .dispatch("login", this.model)
        .then(() => {
          this.buttonLoading = false;
          this.$router.replace({ name: "Home" });
        })
        .catch(() => {
          this.buttonLoading = false;
          this.model.password = "";
          this.$buefy.toast.open({
            message: "Failed user authenticate, please try again.",
            type: "is-danger"
          });
        });
    }
  }
};
</script>

<style></style>
