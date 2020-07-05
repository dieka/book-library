import axios from "axios";
import config from "./config/api";

const instance = axios.create({
  baseURL: config.API_URL,
  timeout: 30000
});
instance.defaults.headers.common["Accepts"] = "application/json";

export { instance, axios };

export default instance;
