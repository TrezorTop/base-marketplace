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

        <div>
          <h3 class="font-bold mb-4">Shop</h3>
          <ul class="space-y-2">
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                All Products
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Categories
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Deals
              </NuxtLink>
            </li>
          </ul>
        </div>

        <div>
          <h3 class="font-bold mb-4">Company</h3>
          <ul class="space-y-2">
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                About Us
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Contact
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Careers
              </NuxtLink>
            </li>
          </ul>
        </div>

        <div>
          <h3 class="font-bold mb-4">Support</h3>
          <ul class="space-y-2">
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Help Center
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Privacy Policy
              </NuxtLink>
            </li>
            <li>
              <NuxtLink
                class="text-gray-500 dark:text-gray-400 hover:text-primary transition-colors"
              >
                Terms of Service
              </NuxtLink>
            </li>
          </ul>
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

<script setup lang="ts">
import { NuxtLink } from '#components'

// Footer component for the marketplace app
</script>
