<script setup lang="ts">
import { useCartStore } from "~/stores/cart.store";

type Props = {
  id: string;
  image?: string; // Add optional image prop
};

const { id, image } = defineProps<Props>();

const cartStore = useCartStore();

const onProductClick = () => {
  navigateTo(`/products/${id}`);
};

const addToCart = (event: Event) => {
  event.stopPropagation(); // Prevent navigation to product detail page

  cartStore.addToCart(id);

  useToast().add({
    title: "Added to cart",
    description: "Product has been added to your cart",
    icon: "i-heroicons-check-circle",
  });
};
</script>

<template>
  <UCard
    :ui="{
      root: 'flex flex-col cursor-pointer hover:shadow-lg transition-shadow',
      body: 'flex-grow',
    }"
    @click="onProductClick"
  >
    <template #header>
      <div class="aspect-video bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
        <template v-if="image">
          <NuxtImg :src="`images/${image}`" class="object-cover w-full h-full" alt="" />
        </template>
        <template v-else>
          <UIcon name="i-heroicons-photo" class="text-4xl text-gray-400" />
        </template>
      </div>
    </template>

    <h3 class="text-lg font-medium"><slot name="name" /></h3>
    <p class="text-gray-500 dark:text-gray-400 mt-1">
      <slot name="description" />
    </p>

    <template #footer>
      <div class="flex items-center justify-between">
        <span class="font-bold"><slot name="price" /></span>
        <UButton
          size="sm"
          icon="i-heroicons-shopping-cart"
          class="cursor-pointer"
          @click="addToCart"
        >
          Add to Cart
        </UButton>
      </div>
    </template>
  </UCard>
</template>

<style scoped></style>
