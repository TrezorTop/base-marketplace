<script setup lang="ts">
import ProductsCatalog from "~/components/pages/products/ProductsCatalog/ProductsCatalog.vue";
import CategoriesList from "~/components/pages/products/CategoriesList/CategoriesList.vue";
import ProductsTraits from "~/components/pages/products/ProductsTraits/ProductsTraits.vue";
import { useProductsStore } from "~/stores/products.store";
import { useCategoriesStore } from "~/stores/categories.store";
import { watchDebounced } from "#imports";
import { FETCH_DEBOUNCE } from "~/consts/fetch-debounce";

useHead({
  title: "Products - Marketplace",
  meta: [
    {
      name: "description",
      content: "Browse our wide selection of products. Find the best deals and latest items.",
    },
  ],
});

// Use the products store directly
const productsStore = useProductsStore();
const categoriesStore = useCategoriesStore();

// Initial products fetch
await useAsyncData(() => productsStore.getProducts());

// Create a local ref for the current page that's synced with the store
const currentPage = computed({
  get: () => productsStore.currentPage,
  set: page => productsStore.setPage(page),
});

// Watch for changes in filters to fetch products
watchDebounced(
  [
    () => productsStore.priceRange,
    () => productsStore.selectedTraits,
    () => categoriesStore.selectedCategories,
  ],
  () => {
    // Reset to page 1 when filters change
    productsStore.currentPage = 1;
    productsStore.getProducts();
  },
  { deep: true, debounce: FETCH_DEBOUNCE },
);
</script>

<template>
  <div>
    <h1 class="text-4xl font-bold mb-6">Our Products</h1>

    <CategoriesList class="mb-8" />

    <ProductsTraits class="mb-8" />

    <ProductsCatalog class="mb-8" />

    <div class="flex justify-center">
      <UPagination
        v-if="productsStore.totalProducts > 0"
        v-model:page="currentPage"
        :total="productsStore.totalProducts"
        :items-per-page="productsStore.itemsPerPage"
      />
    </div>
  </div>
</template>

<style scoped></style>
