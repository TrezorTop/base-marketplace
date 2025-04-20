<script setup lang="ts">
import Product from "~/components/ui/Product/Product.vue";
</script>

<template>
  <section>
    <h2 class="text-2xl font-semibold mb-4">Featured Products</h2>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <Product v-for="i in 3" :key="i" />
    </div>

    <div class="flex justify-center">
      <UButton to="/products">More Products</UButton>
    </div>
  </section>
</template>

<style scoped></style>
