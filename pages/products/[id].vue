<script setup lang="ts">
import { useProductsStore } from "~/stores/products.store";
import { useCartStore } from "~/stores/cart.store";

const route = useRoute();
const productsStore = useProductsStore();
const cartStore = useCartStore();

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

// Function to add the current product to the cart
const addToCart = () => {
  if (!product.value) {
    console.error("Product not found");

    return;
  }

  cartStore.addToCart(product.value.id);

  useToast().add({
    title: "Added to cart",
    description: "Product has been added to your cart",
    icon: "i-heroicons-check-circle",
  });
};

// Set page title
useHead({
  title: `${product.value.name} - Base Marketplace`,
});
</script>

<template>
  <div v-if="product" class="container mx-auto py-8 px-4">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
      <div
        class="bg-gray-100 dark:bg-gray-800 aspect-square flex items-center justify-center rounded-lg overflow-hidden"
      >
        <template v-if="product.image">
          <NuxtImg :src="`images/${product.image}`" class="object-cover w-full h-full" alt="" />
        </template>
        <template v-else>
          <UIcon name="i-heroicons-photo" class="text-6xl text-gray-400" />
        </template>
      </div>

      <div>
        <h1 class="text-3xl font-bold mb-2">{{ product.name }}</h1>
        <p class="text-2xl font-bold text-primary mb-4">${{ product.price.toFixed(2) }}</p>

        <div class="mb-6">
          <h2 class="text-xl font-semibold mb-2">Description</h2>
          <p class="text-gray-600 dark:text-gray-300">{{ product.description }}</p>
        </div>

        <div v-if="product.categoryId" class="mb-6">
          <h2 class="text-xl font-semibold mb-2">Category</h2>
          <UBadge color="primary">{{ product.category?.title || "Unknown Category" }}</UBadge>
        </div>

        <div
          v-if="
            product.traits &&
            typeof product.traits === 'object' &&
            Object.keys(product.traits).length > 0
          "
          class="mb-6"
        >
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
          class="w-full md:w-auto cursor-pointer"
          @click="addToCart"
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
