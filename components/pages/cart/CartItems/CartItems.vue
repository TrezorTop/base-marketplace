<script setup lang="ts">
import { useCartStore } from "~/stores/cart.store";

const cartStore = useCartStore();
</script>

<template>
  <div class="lg:col-span-2">
    <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm overflow-hidden">
      <div class="divide-y divide-gray-200 dark:divide-gray-700">
        <div
          v-for="item in cartStore.cartProducts"
          :key="item.product.id"
          class="p-4 flex flex-col sm:flex-row items-start sm:items-center gap-4"
        >
          <div
            class="bg-gray-100 dark:bg-gray-700 w-20 h-20 flex-shrink-0 rounded-md flex items-center justify-center overflow-hidden"
          >
            <template v-if="item.product.image">
              <NuxtImg
                :src="`images/${item.product.image}`"
                class="object-cover w-full h-full"
                alt=""
              />
            </template>
            <template v-else>
              <UIcon name="i-heroicons-photo" class="text-2xl text-gray-400" />
            </template>
          </div>

          <div class="flex-grow">
            <h3 class="font-medium">{{ item.product.name }}</h3>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-2">
              {{ item.product.description.substring(0, 100) }}
              {{ item.product.description.length > 100 ? "..." : "" }}
            </p>
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-2">
                <UButton
                  size="xs"
                  color="neutral"
                  variant="soft"
                  icon="i-heroicons-minus"
                  :disabled="item.quantity <= 1"
                  class="cursor-pointer"
                  @click="cartStore.updateQuantity(item.product.id, item.quantity - 1)"
                />

                <span class="w-8 text-center">{{ item.quantity }}</span>

                <UButton
                  size="xs"
                  color="neutral"
                  variant="soft"
                  icon="i-heroicons-plus"
                  class="cursor-pointer"
                  @click="cartStore.updateQuantity(item.product.id, item.quantity + 1)"
                />
              </div>
            </div>
          </div>

          <div class="font-bold text-right">
            ${{ (item.product.price * item.quantity).toFixed(2) }}
          </div>

          <UButton
            size="xs"
            color="neutral"
            variant="soft"
            icon="i-heroicons-trash"
            class="cursor-pointer"
            @click="cartStore.removeFromCart(item.product.id)"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
