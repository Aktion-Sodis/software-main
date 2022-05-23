<template>
  <div>
    <div class="icon-wrapper" @click="togglePanel">
      <i class="icon fa-solid fa-bell"></i>
    </div>

    <div class="panel" v-if="isPopup">
      <div class="title">
        <h5>Notification</h5>
      </div>
      <div class="content">
        <div
          class="notification"
          v-for="notification in notifications"
          :key="notification.id"
        >
          {{ notification.message }}
        </div>
      </div>
    </div>
    <div v-if="isPopup" class="outside" v-on:click="away()"></div>
  </div>
</template>

<script>
import { ref } from "vue";

const isPopup = ref(true);

export default {
  setup() {
    return { isPopup };
  },
  methods: {
    togglePanel() {
      console.log(isPopup);
      return (isPopup.value = !isPopup.value);
    },
    away() {
      isPopup.value = false;
    },
  },
  data() {
    return {
      notifications: [
        {
          id: 1,
          date: "23/5/2022",
          message: "Du hast eine neue Benachrichtigung",
          type: "Success",
        },
        {
          id: 2,
          message: "Das ist ein Alarm",
          type: "Danger",
        },
      ],
    };
  },
};
</script>

<style scoped>
.icon {
  height: 20px;
  color: rgb(0, 0, 0);
  margin: 0 10px;
}
.panel {
  position: absolute;
  top: var(--navbar-height);
  right: 5px;
  width: 320px;
  max-height: 420px;
  overflow-y: scroll;

  background-color: white;
  border-radius: 0px 0px 5px 5px;
  border: 1px solid rgb(208, 208, 208);

  display: flex;
  flex-direction: column;
  align-items: center;

  z-index: 3;
}
.notification {
  width: 242px;
  height: 38px;
  padding: 14px;
  margin: 5px 0;
  border-radius: 5px;
  border: 0.5px solid rgb(179, 179, 179);
}

/* Div to close component when clicked somewhere else */
.outside {
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0px;
  left: 0px;
  z-index: 2;
}
</style>
