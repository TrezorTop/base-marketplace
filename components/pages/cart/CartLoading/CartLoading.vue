<script setup lang="ts"></script>

<template>
  <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
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
</template>

<style scoped></style>
