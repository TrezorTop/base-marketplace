<script setup lang="ts">
import WhyChooseUs from '~/components/pages/index/WhyChooseUs/WhyChooseUs.vue'
import Newsletter from '~/components/pages/index/Newsletter/Newsletter.vue'
import FeaturedProducts from '~/components/pages/index/FeaturedProducts/FeaturedProducts.vue'

useHead({
  title: 'Home - Marketplace',
  meta: [
    {
      name: 'description',
      content: 'Welcome to our marketplace. Browse our featured products and latest deals.'
    }
  ]
})
</script>

<template>
  <div>
    <UAlert
      title="Welcome to our Marketplace!"
      description="We're excited to have you here. Explore our products and find what you need."
      color="primary"
      variant="soft"
      icon="i-heroicons-information-circle"
      class="mb-8"
    />

    <h1 class="text-4xl font-bold mb-6">Welcome to Marketplace</h1>

    <div class="flex flex-col gap-16">
      <FeaturedProducts />

      <WhyChooseUs />

      <Newsletter />
    </div>
  </div>
</template>

<style scoped></style>
