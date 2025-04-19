<script setup lang="ts">
import Product from '~/components/ui/Product/Product.vue'
</script>

<template>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
    <Product v-for="i in 8" :key="i"/>
  </div>
</template>

<style scoped></style>
