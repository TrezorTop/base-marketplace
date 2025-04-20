<template>
  <footer class="bg-gray-50 dark:bg-gray-900 border-t border-gray-200 dark:border-gray-800 mt-auto">
    <UContainer class="py-8">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
          <h3 class="font-bold text-lg mb-4">Marketplace</h3>
          <p class="text-gray-500 dark:text-gray-400 mb-4">
            Your one-stop shop for all your needs.
          </p>
        </div>
      </div>

      <div
        class="border-t border-gray-200 dark:border-gray-800 mt-8 pt-8 text-center text-gray-500 dark:text-gray-400"
      >
        <p>&copy; {{ new Date().getFullYear() }} Marketplace. No rights reserved.</p>
      </div>
    </UContainer>
  </footer>
</template>

<script setup lang="ts"></script>
