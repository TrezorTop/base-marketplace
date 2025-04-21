<script setup lang="ts">
import { useCartStore } from "~/stores/cart.store";
import { usePaymentStore } from "~/stores/payment.store";
import CartLoading from "~/components/pages/cart/CartLoading/CartLoading.vue";
import CartEmpty from "~/components/pages/cart/CartEmpty/CartEmpty.vue";
import CartItems from "~/components/pages/cart/CartItems/CartItems.vue";
import OrderSummary from "~/components/pages/cart/OrderSummary/OrderSummary.vue";
import UserDetailsForm from "~/components/pages/cart/UserDetailsForm/UserDetailsForm.vue";

const cartStore = useCartStore();
const paymentStore = usePaymentStore();
const toast = useToast();

useHead({
  title: "Shopping Cart - Base Marketplace",
});

const { status } = await useAsyncData(cartStore.fetchCartProducts, {
  server: false,
});

const isLoading = computed(() => {
  return status.value === "pending" || status.value === "idle";
});

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

    <CartLoading v-if="isLoading" />

    <CartEmpty v-else-if="!cartStore.totalItems" />

    <div v-else class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <CartItems />

      <div class="lg:col-span-1">
        <div class="bg-white dark:bg-gray-800 rounded-lg shadow-sm p-6">
          <OrderSummary />

          <UserDetailsForm />

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
            :disabled="paymentStore.isProcessing"
            @click="cartStore.clearCart()"
          >
            Clear Cart
          </UButton>
        </div>
      </div>
    </div>

    <div v-if="!isLoading" class="mt-12">
      <UButton to="/products" icon="i-heroicons-arrow-left" variant="ghost">
        Continue Shopping
      </UButton>
    </div>
  </div>
</template>
