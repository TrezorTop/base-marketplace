<script setup lang="ts">
import Product from "~/components/ui/Product/Product.vue";
import { useProductsStore } from "~/stores/products.store";

const productsStore = useProductsStore();

// Computed property to check if there are no products
const noProducts = computed(() => productsStore.products.length === 0);
</script>

<template>
  <div>
    <!-- No products message -->
    <div v-if="noProducts" class="text-center py-8">
      <p class="text-lg text-gray-500">
        No products match your filters. Try adjusting your criteria.
      </p>
    </div>

    <!-- Products grid -->
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <Product v-for="product in productsStore.products" :key="product.id">
        <template #name>{{ product.name }}</template>
        <template #description>{{ product.description }}</template>
        <template #price>${{ product.price.toFixed(2) }}</template>
      </Product>
    </div>
  </div>
</template>

<style scoped></style>
