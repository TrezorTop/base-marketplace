<script setup lang="ts"></script>

<template>
  <UCard>
    <template #header>
      <div class="aspect-video bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
        <UIcon name="i-heroicons-photo" class="text-4xl text-gray-400" />
      </div>
    </template>
    <div>
      <h3 class="text-lg font-medium">Product</h3>
      <p class="text-gray-500 dark:text-gray-400 mt-1">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
      </p>
    </div>
    <template #footer>
      <div class="flex items-center justify-between">
        <span class="font-bold">${{ 19.99 }}</span>
        <UButton size="sm" icon="i-heroicons-shopping-cart"> Add to Cart</UButton>
      </div>
    </template>
  </UCard>
</template>

<style scoped></style>
