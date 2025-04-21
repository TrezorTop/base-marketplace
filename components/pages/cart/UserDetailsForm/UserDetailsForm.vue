<script setup lang="ts"></script>

<template>
  <div class="space-y-4 mb-4 border-t border-gray-200 dark:border-gray-700 pt-4">
    <h3 class="font-medium">User Details</h3>

    <div>
      <label class="block text-sm font-medium mb-1">Full Name</label>
      <UInput placeholder="John Doe" />
    </div>

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
</template>

<style scoped></style>
