<script setup lang="ts"></script>

<template>
  <section>
    <h2 class="text-2xl font-semibold mb-4">Why Choose Us</h2>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="flex flex-col items-center text-center p-4">
        <UIcon name="i-heroicons-truck" class="text-4xl text-primary mb-4" />
        <h3 class="text-lg font-medium mb-2">Fast Delivery</h3>
        <p class="text-gray-500 dark:text-gray-400">
          Get your products delivered quickly and reliably.
        </p>
      </div>
      <div class="flex flex-col items-center text-center p-4">
        <UIcon name="i-heroicons-shield-check" class="text-4xl text-primary mb-4" />
        <h3 class="text-lg font-medium mb-2">Secure Payments</h3>
        <p class="text-gray-500 dark:text-gray-400">
          Your transactions are always safe and secure.
        </p>
      </div>
      <div class="flex flex-col items-center text-center p-4">
        <UIcon name="i-heroicons-arrow-path" class="text-4xl text-primary mb-4" />
        <h3 class="text-lg font-medium mb-2">Easy Returns</h3>
        <p class="text-gray-500 dark:text-gray-400">
          Not satisfied? Return your products hassle-free.
        </p>
      </div>
    </div>
  </section>
</template>

<style scoped></style>
