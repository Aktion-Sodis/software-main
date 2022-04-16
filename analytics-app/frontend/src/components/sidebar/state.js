import { ref, computed } from 'vue'

export const collapsed = ref(true)
export const openSidebar = () => (collapsed.value = false)
export const closeSidebar = () => (collapsed.value = true)

export const SIDEBAR_WIDTH = 180
export const SIDEBAR_WIDTH_COLLAPSED = 38
export const sidebarWidth = computed(
  () => `${collapsed.value ? SIDEBAR_WIDTH_COLLAPSED : SIDEBAR_WIDTH}px`
)
export const sidebarTransition = '0.4s ease'