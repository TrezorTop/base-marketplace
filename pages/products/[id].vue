<script setup lang="ts">
import { useProductsStore } from "~/stores/products.store";

const route = useRoute();
const productsStore = useProductsStore();

// Get the product ID from the route params
const productId = route.params.id as string;

// Fetch the product details
await useAsyncData(async () => productsStore.getProductById(productId));

// Access the current product from the store
const product = computed(() => productsStore.currentProduct);

// Handle case where product is not found
if (!product.value) {
  throw createError({
    statusCode: 404,
    statusMessage: "Product not found",
  });
}

// Set page title
useHead({
  title: `${product.value.name} - Base Marketplace`,
});
</script>

<template>
  <div v-if="product" class="container mx-auto py-8 px-4">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
      <div
        class="bg-gray-100 dark:bg-gray-800 aspect-square flex items-center justify-center rounded-lg"
      >
        <UIcon name="i-heroicons-photo" class="text-6xl text-gray-400" />
      </div>

      <div>
        <h1 class="text-3xl font-bold mb-2">{{ product.name }}</h1>
        <p class="text-2xl font-bold text-primary mb-4">${{ product.price }}</p>

        <div class="mb-6">
          <h2 class="text-xl font-semibold mb-2">Description</h2>
          <p class="text-gray-600 dark:text-gray-300">{{ product.description }}</p>
        </div>

        <div class="mb-6" v-if="product.categoryId">
          <h2 class="text-xl font-semibold mb-2">Category</h2>
          <UBadge color="primary">{{ product.category?.name || "Unknown Category" }}</UBadge>
        </div>

        <div class="mb-6" v-if="product.traits && typeof product.traits === 'object' && Object.keys(product.traits).length > 0">
          <h2 class="text-xl font-semibold mb-2">Specifications</h2>
          <div class="grid grid-cols-1 gap-2">
            <div v-for="(trait, key) in product.traits" :key="key" class="flex">
              <span class="font-medium min-w-[150px]">{{ trait?.title || key }}:</span>
              <span>{{ trait?.value }}</span>
            </div>
          </div>
        </div>

        <UButton
          size="lg"
          color="primary"
          icon="i-heroicons-shopping-cart"
          class="w-full md:w-auto"
        >
          Add to Cart
        </UButton>
      </div>
    </div>

    <div class="mt-12">
      <UButton to="/products" icon="i-heroicons-arrow-left" variant="ghost">
        Back to Products
      </UButton>
    </div>
  </div>
</template>
