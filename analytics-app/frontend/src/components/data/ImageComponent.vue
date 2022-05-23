<template>
  <div class="images" @click="getImageList(images)">
    <ImageCard
      v-for="(image, index) in images"
      :key="image.id"
      :image="image"
      :index="index"
      :preview="getImageList(images)"
    />
  </div>
</template>

<script>
import ImageCard from "../image/ImageCard.vue";

export default {
  components: { ImageCard },
  methods: {
    printIMGsrc(src) {
      console.log(src);
    },
    getImageList(images) {
      var imageArray = [];
      for (var i = 0, l = images.length; i < l; i++) {
        var src = images[i].img_src;
        imageArray.push(src);
      }
      return imageArray;
    },
  },
  data() {
    return {
      images: [
        {
          img_id: 1,
          img_src:
            "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg",
        },
        {
          img_id: 2,
          img_src:
            "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg",
        },
        {
          img_id: 3,
          img_src:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg",
        },
        {
          img_id: 4,
          img_src:
            "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg",
        },
        {
          img_id: 5,
          img_src:
            "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg",
        },
        {
          img_id: 6,
          img_src:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg",
        },
        {
          img_id: 7,
          img_src:
            "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg",
        },
        {
          img_id: 8,
          img_src:
            "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg",
        },
        {
          img_id: 9,
          img_src:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg",
        },
        {
          img_id: 10,
          img_src:
            "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg",
        },
        {
          img_id: 11,
          img_src:
            "https://www.dignited.com/wp-content/uploads/2018/09/url_istock_nicozorn_thumb800.jpg",
        },
        {
          img_id: 12,
          img_src:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/WindparkBeltheimII_%28hochkant%29.jpg/1200px-WindparkBeltheimII_%28hochkant%29.jpg",
        },
      ],
    };
  },
};
</script>

<style scoped>
.images {
  display: flex;
  flex-wrap: wrap;
  width: calc(100vw - var(--left-menu-width) - 80px);
  height: calc(100vh - var(--navbar-height) - 60px);
}
</style>
