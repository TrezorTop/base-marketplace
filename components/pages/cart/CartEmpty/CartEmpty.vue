<script setup lang="ts"></script>

<template>
  <div class="text-center py-12">
    <UIcon name="i-heroicons-shopping-cart" class="text-6xl text-gray-400 mx-auto mb-4" />
    <h2 class="text-2xl font-medium mb-2">Your cart is empty</h2>
    <p class="text-gray-500 dark:text-gray-400 mb-6">
      Add some products to your cart to see them here.
    </p>
    <UButton to="/products" color="primary"> Browse Products </UButton>
  </div>
</template>

<style scoped></style>
