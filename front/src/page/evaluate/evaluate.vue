<template>
  <div>
    <head-top head-title="订单评价" go-back='true'></head-top>
    <div class="evaluate-box">
      <div class="evaluate-item">
        <span class="title">服务态度:</span>
        <star-rating
          v-model="rating1"
          :round-start-rating="false"
          v-bind:star-size="30"
          :show-rating="false"
          v-bind:inline="true"
        />
      </div>
      <div class="evaluate-item">
        <span class="title">菜品评价:</span>
        <star-rating
          v-model="rating2"
          :round-start-rating="false"
          v-bind:star-size="30"
          :show-rating="false"
          v-bind:inline="true"
        />
      </div>
      <textarea v-model="contents" rows="8" placeholder="说点什么吧"></textarea>
      <div class="login_container" @click="submitEvaluate">提交</div>
      <alert-tip v-if="showAlert" @closeTip="closeTipFun" :alertText="alertText"></alert-tip>
    </div>
  </div>
</template>

<script>
  import headTop from 'src/components/header/head'
  import StarRating from 'vue-star-rating'
  import {orderEvaluate} from '../../service/getData'
  import alertTip from 'src/components/common/alertTip'
  export default {
    name: "evaluate",
    data() {
      return {
        rating1: 0,
        rating2: 0,
        contents: '',
        order_sn: '',
        showAlert: false,
        alertText: null,
      }
    },
    components: {
      headTop,
      StarRating,
      alertTip
    },
    created() {
      this.order_sn = this.$route.query.order_sn;
    },
    methods: {
      submitEvaluate: function () {
        if (this.rating1 == 0 || this.rating2 == 0) {
          alert('评分选择不完整');
          return false
        }
        orderEvaluate(this.order_sn, this.rating1, this.rating2, this.contents).then((res) => {
          if (res.code === 200) {
            this.showAlert = true;
            this.alertText = '评论成功';
          }
        })
      },
      closeTipFun() {
        this.showAlert = false;
        this.$router.push('/order');
      },
    }
  }

</script>

<style lang="scss" scoped>
  @import '../../style/mixin';

  .evaluate-box {
    padding: 1.6rem 1rem;
  }

  .vue-star-rating {
    margin-top: 0.5rem;
  }

  textarea {
    width: 100%;
    background: #fff;
    margin: 1rem 0;
    padding: 0.2rem;
  }

  .evaluate-item .title {
    font-size: 0.7rem;
    margin: 0 4px;
  }

  .login_container {
    margin: 0 .5rem 1rem;
    @include sc(.7rem, #fff);
    background-color: #3190e8;
    padding: .5rem 0;
    border: 1px;
    border-radius: 0.15rem;
    text-align: center;
  }

</style>
