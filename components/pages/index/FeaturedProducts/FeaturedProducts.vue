<script setup lang="ts">
import Product from "~/components/ui/Product/Product.vue";

const productsStore = useProductsStore();

await callOnce(productsStore.getFeaturedProducts);
</script>

<template>
  <section>
    <h2 class="text-2xl font-semibold mb-4">Featured Products</h2>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <Product 
        v-for="product in productsStore.featuredProducts" 
        :id="product.id"
        :image="product.image"
        :key="product.id"
      >
        <template #name>{{ product.name }}</template>

        <template #description>{{ product.description }}</template>

        <template #price>${{ product.price.toFixed(2) }}</template>
      </Product>
    </div>

    <div class="flex justify-center">
      <UButton to="/products">More Products</UButton>
    </div>
  </section>
</template>

<style scoped></style>
