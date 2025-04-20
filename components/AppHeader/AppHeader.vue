<template>
  <header class="border-b border-gray-200 dark:border-gray-800">
    <UContainer class="flex items-center justify-between py-3">
      <NuxtLink to="/" class="flex items-center gap-2 font-bold text-xl">
        <UIcon name="i-heroicons-shopping-bag" class="text-primary" />
        Marketplace
      </NuxtLink>
      <nav>
        <ul class="flex items-center gap-6">
          <li>
            <NuxtLink to="/" class="hover:text-primary transition-colors">Home</NuxtLink>
          </li>
          <li>
            <NuxtLink to="/products" class="hover:text-primary transition-colors"
              >Products</NuxtLink
            >
          </li>
        </ul>
      </nav>
      <div class="grid grid-cols-3 items-center gap-4">
        <UButton
          icon="i-heroicons-shopping-cart"
          color="neutral"
          variant="ghost"
          aria-label="Shopping cart"
        />

        <UButton
          icon="i-heroicons-user-circle"
          color="neutral"
          variant="ghost"
          aria-label="User account"
        />

        <!--        <ClientOnly>-->
        <!--          <UButton-->
        <!--            :icon="isDark ? 'i-heroicons-sun' : 'i-heroicons-moon'"-->
        <!--            color="neutral"-->
        <!--            variant="ghost"-->
        <!--            aria-label="Toggle color mode"-->
        <!--            @click="isDark = !isDark"-->
        <!--          />-->
        <!--        </ClientOnly>-->
      </div>
    </UContainer>
  </header>
</template>

<script setup lang="ts">
import { NuxtLink } from "#components";
import { computed, useColorMode } from "#imports";

const colorMode = useColorMode();

const isDark = computed({
  get() {
    return colorMode.value === "dark";
  },
  set(value) {
    colorMode.preference = value ? "dark" : "light";
  },
});
</script>
