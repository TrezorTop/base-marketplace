<script setup lang="ts">
import { useCartStore } from "~/stores/cart.store";
import { usePaymentStore } from "~/stores/payment.store";

const cartStore = useCartStore();
const paymentStore = usePaymentStore();
const toast = useToast();

// Set page title
useHead({
  title: "Shopping Cart - Base Marketplace",
});

const { status } = await useAsyncData(cartStore.fetchCartProducts, {
  server: false,
});

const isLoading = computed(() => {
  return status.value === "pending" || status.value === "idle";
});

const formatPrice = (price: number) => {
  return `$${price.toFixed(2)}`;
};

// Process payment
const handlePayment = async () => {
  const result = await paymentStore.processPayment();

  if (result.success) {
    toast.add({
      title: "Successful operation",
      description: result.message,
      icon: "i-heroicons-check-circle",
    });
    cartStore.clearCart();
  } else {
    toast.add({
      title: "Successful not permitted",
      color: "error",
      description: result.message,
      icon: "i-heroicons-check-circle",
    });
  }
};
</script>

<template>
  <div class="container mx-auto py-8 px-4">
    <h1 class="text-3xl font-bold mb-6">Shopping Cart</h1>

    <!-- Loading State -->
    <div v-if="isLoading" class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <div class="lg:col-span-2 space-y-4">
        <div class="flex gap-4 p-4 border border-gray-200 dark:border-gray-700 rounded-lg">
          <USkeleton class="h-20 w-20 rounded-md overflow-hidden" />
          <div class="flex-grow space-y-2">
            <USkeleton class="h-4 w-3/4" />
            <USkeleton class="h-4 w-1/2" />
            <USkeleton class="h-8 w-24" />
          </div>
          <USkeleton class="h-6 w-16" />
        </div>
        <div class="flex gap-4 p-4 border border-gray-200 dark:border-gray-700 rounded-lg">
          <USkeleton class="h-20 w-20 rounded-md overflow-hidden" />
          <div class="flex-grow space-y-2">
            <USkeleton class="h-4 w-3/4" />
            <USkeleton class="h-4 w-1/2" />
            <USkeleton class="h-8 w-24" />
          </div>
          <USkeleton class="h-6 w-16" />
        </div>
      </div>
      <div class="lg:col-span-1">
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-6 space-y-4">
          <USkeleton class="h-6 w-1/2" />
          <USkeleton class="h-4 w-full" />
          <USkeleton class="h-4 w-3/4" />
          <USkeleton class="h-10 w-full" />
          <USkeleton class="h-10 w-full" />
        </div>
      </div>
    </div>

    <!-- Empty Cart State -->
    <div v-else-if="!cartStore.totalItems" class="text-center py-12">
      <UIcon name="i-heroicons-shopping-cart" class="text-6xl text-gray-400 mx-auto mb-4" />
      <h2 class="text-2xl font-medium mb-2">Your cart is empty</h2>
      <p class="text-gray-500 dark:text-gray-400 mb-6">
        Add some products to your cart to see them here.
      </p>
      <UButton to="/products" color="primary"> Browse Products </UButton>
    </div>

    <!-- Cart Content -->
    <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
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
                  <NuxtImg :src="`images/${item.product.image}`" class="object-cover w-full h-full" alt="" />
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
                {{ formatPrice(item.product.price * item.quantity) }}
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

      <div class="lg:col-span-1">
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-6">
          <h2 class="text-xl font-bold mb-4">Order Summary</h2>

          <div class="space-y-2 mb-4">
            <div class="flex justify-between">
              <span>Items ({{ cartStore.totalItems }}):</span>
              <span>{{ formatPrice(cartStore.totalPrice) }}</span>
            </div>
            <div
              class="flex justify-between font-bold text-lg pt-2 border-t border-gray-200 dark:border-gray-700"
            >
              <span>Total:</span>
              <span>{{ formatPrice(cartStore.totalPrice) }}</span>
            </div>
          </div>

          <!-- User Details Form -->
          <div class="space-y-4 mb-4 border-t border-gray-200 dark:border-gray-700 pt-4">
            <h3 class="font-medium">User Details</h3>

            <!-- Name -->
            <div>
              <label class="block text-sm font-medium mb-1">Full Name</label>
              <UInput placeholder="John Doe" />
            </div>

            <!-- Address -->
            <div>
              <label class="block text-sm font-medium mb-1">Street Address</label>
              <UInput placeholder="123 Main St" />
            </div>

            <div class="grid grid-cols-2 gap-2">
              <div>
                <label class="block text-sm font-medium mb-1">City</label>
                <UInput placeholder="New York" />
              </div>
              <div>
                <label class="block text-sm font-medium mb-1">State</label>
                <UInput placeholder="NY" />
              </div>
            </div>

            <div class="grid grid-cols-2 gap-2">
              <div>
                <label class="block text-sm font-medium mb-1">Zip Code</label>
                <UInput placeholder="10001" />
              </div>
              <div>
                <label class="block text-sm font-medium mb-1">Country</label>
                <UInput placeholder="USA" />
              </div>
            </div>

            <!-- Payment Info -->
            <h3 class="font-medium pt-2">Payment Information</h3>

            <div>
              <label class="block text-sm font-medium mb-1">Card Number</label>
              <UInput placeholder="4111 1111 1111 1111" />
            </div>

            <div>
              <label class="block text-sm font-medium mb-1">Cardholder Name</label>
              <UInput placeholder="John Doe" />
            </div>

            <div class="grid grid-cols-2 gap-2">
              <div>
                <label class="block text-sm font-medium mb-1">Expiry Date</label>
                <UInput placeholder="MM/YY" />
              </div>
              <div>
                <label class="block text-sm font-medium mb-1">CVV</label>
                <UInput placeholder="123" type="password" />
              </div>
            </div>
          </div>

          <UButton
            color="primary"
            block
            class="mb-2 cursor-pointer"
            :loading="paymentStore.isProcessing"
            :disabled="paymentStore.isProcessing"
            @click="handlePayment"
          >
            Proceed Payment
          </UButton>

          <UButton
            color="neutral"
            variant="soft"
            block
            class="cursor-pointer"
            @click="cartStore.clearCart()"
          >
            Clear Cart
          </UButton>
        </div>
      </div>
    </div>

    <!-- Continue Shopping Button (show only when not loading) -->
    <div v-if="!isLoading" class="mt-12">
      <UButton to="/products" icon="i-heroicons-arrow-left" variant="ghost">
        Continue Shopping
      </UButton>
    </div>
  </div>
</template>
