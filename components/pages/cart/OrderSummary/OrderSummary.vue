<script setup lang="ts">
import { useCartStore } from "~/stores/cart.store";

const cartStore = useCartStore();
</script>

<template>
  <h2 class="text-xl font-bold mb-4">Order Summary</h2>

  <div class="space-y-2 mb-4">
    <div class="flex justify-between">
      <span>Items ({{ cartStore.totalItems }}):</span>
      <span>${{ cartStore.totalPrice.toFixed(2) }}</span>
    </div>
    <div
      class="flex justify-between font-bold text-lg pt-2 border-t border-gray-200 dark:border-gray-700"
    >
      <span>Total:</span>
      <span>${{ cartStore.totalPrice.toFixed(2) }}</span>
    </div>
  </div>
</template>

<style scoped></style>
