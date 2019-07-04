<template>
  <div>
    <nav class="msite_nav">
      <div class="swiper-container" v-if="foodTypes.length">
        <div class="swiper-wrapper">
          <div class="swiper-slide" v-for="(item, index) in foodTypes" :key="index">
            <img :src="item.image_url" style="width: 100%;">
          </div>
        </div>
        <div class="swiper-pagination"></div>
      </div>
    </nav>
    <div class="shop_list_container">
      <header class="shop_header">
        <svg class="shop_icon">
          <use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#shop"></use>
        </svg>
        <span class="shop_header_title">附近商家</span>
      </header>
      <shop-list v-if="hasGetData" :geohash="geohash"></shop-list>
    </div>
    <foot-guide></foot-guide>
  </div>
</template>

<script>
  import headTop from 'src/components/header/head'
  import footGuide from 'src/components/footer/footGuide'
  import shopList from 'src/components/common/shoplist'
  import {msiteFoodTypes} from 'src/service/getData'
  import 'src/plugins/swiper.min.js'
  import 'src/style/swiper.min.css'

  export default {
    data() {
      return {
        geohash: '1',
        msiteTitle: '请选择地址...', // msite页面头部标题
        foodTypes: [], // 食品分类列表
        hasGetData: true, //是否已经获取地理位置数据，成功之后再获取商铺列表信息
      }
    },
    mounted() {
      //获取导航食品类型列表
      msiteFoodTypes().then(res => {
        this.foodTypes = res.data;
        //初始化swiper
        new Swiper('.swiper-container', {
          pagination: '.swiper-pagination',
          autoplay: 3000,
        });
      })
    },
    components: {
      headTop,
      shopList,
      footGuide,
    },
    computed: {},
    methods: {},
    watch: {}
  }

</script>

<style lang="scss" scoped>
  @import 'src/style/mixin';

  .link_search {
    left: .8rem;
    @include wh(.9rem, .9rem);
    @include ct;
  }

  .msite_title {
    @include center;
    width: 50%;
    color: #fff;
    text-align: center;
    margin-left: -0.5rem;
    .title_text {
      @include sc(0.8rem, #fff);
      text-align: center;
      display: block;
    }
  }

  .msite_nav {
    background-color: #fff;
    .swiper-container {
       width: 100%;
      .swiper-pagination {
        bottom: 0.2rem;
      }
    }
    .fl_back {
      @include wh(100%, 100%);
    }
  }

  .food_types_container {
    display: flex;
    flex-wrap: wrap;
    .link_to_food {
      width: 25%;
      padding: 0.3rem 0rem;
      @include fj(center);
      figure {
        img {
          margin-bottom: 0.3rem;
          @include wh(1.8rem, 1.8rem);
        }
        figcaption {
          text-align: center;
          @include sc(0.55rem, #666);
        }
      }
    }
  }

  .shop_list_container {
    margin-top: .4rem;
    border-top: 0.025rem solid $bc;
    background-color: #fff;
    .shop_header {
      .shop_icon {
        fill: #999;
        margin-left: 0.6rem;
        vertical-align: middle;
        @include wh(0.6rem, 0.6rem);
      }
      .shop_header_title {
        color: #999;
        @include font(0.55rem, 1.6rem);
      }
    }
  }

</style>
