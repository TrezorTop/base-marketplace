<template>
  <UApp>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </UApp>
</template>

<script setup lang="ts">
useHead({
  title: 'Marketplace - Your One-Stop Shop',
  meta: [
    {
      name: 'description',
      content:
        'Discover a wide range of products at our online marketplace. Shop with confidence and enjoy fast delivery.'
    },
    { name: 'keywords', content: 'marketplace, online shopping, products, ecommerce' },
    { name: 'viewport', content: 'width=device-width, initial-scale=1' },
    { property: 'og:title', content: 'Marketplace - Your One-Stop Shop' },
    {
      property: 'og:description',
      content:
        'Discover a wide range of products at our online marketplace. Shop with confidence and enjoy fast delivery.'
    },
    { property: 'og:type', content: 'website' },
    { name: 'twitter:card', content: 'summary_large_image' },
    { name: 'twitter:title', content: 'Marketplace - Your One-Stop Shop' },
    {
      name: 'twitter:description',
      content: 'Discover a wide range of products at our online marketplace.'
    }
  ],
  link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }]
})
</script>
