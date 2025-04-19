<script setup lang="ts">
import ProductsCatalog from '~/components/pages/products/ProductsCatalog/ProductsCatalog.vue'

useHead({
  title: 'Products - Marketplace',
  meta: [
    {
      name: 'description',
      content: 'Browse our wide selection of products. Find the best deals and latest items.'
    }
  ]
})
</script>

<template>
  <div>
    <h1 class="text-4xl font-bold mb-6">Our Products</h1>

    <div class="flex flex-wrap gap-4 mb-8">
      <UButton
        v-for="category in ['All', 'Electronics', 'Clothing', 'Home', 'Beauty', 'Sports']"
        :key="category"
        :color="category === 'All' ? 'primary' : 'neutral'"
        variant="soft"
        size="sm"
        class="rounded-full"
      >
        {{ category }}
      </UButton>
    </div>

    <ProductsCatalog class="mb-8" />

    <div class="flex justify-center">
      <UPagination />
    </div>
  </div>
</template>

<style scoped></style>
