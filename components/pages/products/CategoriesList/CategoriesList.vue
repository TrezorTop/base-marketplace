<script setup lang="ts">
import { useCategoriesStore } from "~/stores/categories.store";

const categoriesStore = useCategoriesStore();

await useAsyncData(categoriesStore.getCategories);

const onCategorySelect = (category: string) => {
  if (categoriesStore.selectedCategoriesMap[category]) {
    categoriesStore.selectedCategories.splice(
      categoriesStore.selectedCategories.indexOf(category),
      1
    );
  } else {
    categoriesStore.selectedCategories.push(category);
  }
};
</script>

<template>
  <div class="flex flex-wrap gap-4">
    <UButton
      v-for="category in categoriesStore.categories"
      :key="category.id"
      :color="categoriesStore.selectedCategoriesMap[category.name] ? 'primary' : 'neutral'"
      variant="soft"
      size="sm"
      class="rounded-full cursor-pointer"
      @click="onCategorySelect(category.name)"
    >
      {{ category.title }}
    </UButton>
  </div>
</template>

<style scoped></style>
