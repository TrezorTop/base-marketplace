<template>
  <div class="flex flex-col min-h-screen">
    <AppHeader />
    <main class="flex-grow">
      <UContainer class="py-8">
        <slot />
      </UContainer>
    </main>
    <AppFooter />
  </div>
</template>

<script setup lang="ts"></script>
