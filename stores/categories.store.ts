import type { CategoriesResponse, Category } from "~/server/api/categories.get";
import api from "~/utils/api";

export const useCategoriesStore = defineStore("category", () => {
  const categories = ref<Category[]>([]);
  const selectedCategories = ref<string[]>([]);

  const selectedCategoriesMap = computed(() => {
    return selectedCategories.value.reduce((acc, category) => {
      acc[category] = true;
      return acc;
    }, {} as Record<string, boolean>);
  });

  const getCategories = async () => {
    const response = await api<CategoriesResponse>("/api/categories");

    categories.value = response.categories;

    return response;
  };

  return {
    categories,
    getCategories,

    selectedCategories,
    selectedCategoriesMap,
  };
});
