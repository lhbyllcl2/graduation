import Axios from 'axios'
import {baseUrl} from './env'
import Qs from "qs"
import {getStore,removeStore} from "./mUtils";
Axios.defaults.timeout = 60000;
Axios.defaults.baseURL = baseUrl;
Axios.interceptors.request.use(
  config => {
    config.data.token = getStore('token');
    if (config.method === 'post') {
      config.data = Qs.stringify(config.data)
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
);
Axios.interceptors.response.use((response) => {
    let responseCode = parseInt(response.data.code);
    if (responseCode === 1002 || responseCode === 1003) {
      removeStore('token');
      return false;
    }
    return response;
  },
  (error) => {
    return Promise.reject(error)
  }
);
export default {
  fetchPost: function (url, params = {}) {
    return new Promise((resolve, reject) => {
      Axios
        .post(url, params).then(response => {
          resolve(response.data)
        },
        err => {
          reject(err)
        }
      )
        .catch(error => {
          return Promise.reject(error)
        })
    })
  },
  fetchGet: function (url, params = {}) {
    return new Promise((resolve, reject) => {
      Axios
        .get(url, {
          params: params
        })
        .then(
          response => {
            resolve(response.data)
          },
          err => {
            reject(err)
          }
        )
        .catch(error => {
          return Promise.reject(error)
        })
    })
  }
}
