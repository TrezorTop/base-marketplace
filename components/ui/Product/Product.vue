<script setup lang="ts">
type Props = {
  id: string;
};

const { id } = defineProps<Props>();

const onProductClick = () => {
  navigateTo(`/products/${id}`);
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
        <UIcon name="i-heroicons-photo" class="text-4xl text-gray-400" />
      </div>
    </template>

    <h3 class="text-lg font-medium"><slot name="name" /></h3>
    <p class="text-gray-500 dark:text-gray-400 mt-1">
      <slot name="description" />
    </p>

    <template #footer>
      <div class="flex items-center justify-between">
        <span class="font-bold"><slot name="price"></slot></span>
        <UButton size="sm" icon="i-heroicons-shopping-cart" class="cursor-pointer">
          Add to Cart
        </UButton>
      </div>
    </template>
  </UCard>
</template>

<style scoped></style>
