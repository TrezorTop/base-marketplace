import type { ProductsFilter, ProductsResponse } from "~/server/api/products.post";
import type { CategoryTrait, TraitsResponse } from "~/server/api/products/traits/index.post";
import { useCategoriesStore } from "~/stores/categories.store";
import type { Product, ProductDetails } from "~/server/utils/types";
import type { FeaturedProductsResponse } from "~/server/api/products/featured/index.get";
import type { ProductResponse } from "~/server/api/products/[id]/index.get";

export const useProductsStore = defineStore("products", () => {
  const products = ref<Product[]>([]);
  const priceRange = ref<{ min?: number; max?: number }>({});
  const selectedTraits = ref<
    {
      categoryId: string;
      name: string;
      values: string[];
    }[]
  >([]);
  const currentPage = ref(1);
  const totalProducts = ref(0);
  const itemsPerPage = 12;

  // Get selected categories from categories store
  const categoriesStore = useCategoriesStore();

  const getProducts = async (filter?: ProductsFilter) => {
    // Build filter object for requests
    const filterToApply: ProductsFilter = filter || {};

    // Add pagination parameters
    filterToApply.page = filter?.page || currentPage.value;
    filterToApply.limit = itemsPerPage;

    // Add price filter if set
    if (priceRange.value.min !== undefined || priceRange.value.max !== undefined) {
      filterToApply.price = priceRange.value;
    }

    // Add category filter if categories are selected
    if (categoriesStore.selectedCategories.length > 0) {
      // Get category IDs from selected category names
      const categoryIds = categoriesStore.categories
        .filter(category => categoriesStore.selectedCategories.includes(category.name))
        .map(category => category.id);

      filterToApply.categoryId = categoryIds;
    }

    // Add traits filter if traits are selected
    if (selectedTraits.value.length > 0) {
      filterToApply.traits = selectedTraits.value;
    }

    const response = await api<ProductsResponse>("/api/products", {
      method: "POST",
      body: filterToApply,
    });

    products.value = response.products;
    totalProducts.value = response.total;
    currentPage.value = filterToApply.page || 1;

    return response;
  };

  const traits = ref<CategoryTrait[]>([]);

  const getTraits = async (categoryIds?: string[]) => {
    // Only fetch traits if categoryIds are provided
    if (!categoryIds || !categoryIds.length) {
      traits.value = [];
      return { traits: [] };
    }

    // Send category IDs in the request body
    const response = await api<TraitsResponse>("/api/products/traits", {
      method: "POST",
      body: {
        categoryIds,
      },
    });

    traits.value = response.traits;

    return response;
  };

  // Method to set price range filter
  const setPriceRange = (min?: number, max?: number) => {
    priceRange.value = { min, max };
  };

  // Method to toggle a trait value selection
  const toggleTraitValue = (categoryId: string, traitName: string, value: string) => {
    // Find if we already have this trait in the array
    const traitIndex = selectedTraits.value.findIndex(
      trait => trait.categoryId === categoryId && trait.name === traitName,
    );

    if (traitIndex === -1) {
      // Trait not found, add it with the value
      selectedTraits.value.push({
        categoryId,
        name: traitName,
        values: [value],
      });
    } else {
      // Trait found, check if value exists
      const valueIndex = selectedTraits.value[traitIndex].values.indexOf(value);

      if (valueIndex === -1) {
        // Value not found, add it
        selectedTraits.value[traitIndex].values.push(value);
      } else {
        // Value found, remove it
        selectedTraits.value[traitIndex].values.splice(valueIndex, 1);

        // If no values left, remove the trait
        if (!selectedTraits.value[traitIndex].values.length) {
          selectedTraits.value.splice(traitIndex, 1);
        }
      }
    }
  };

  // Method to set the current page and fetch products
  const setPage = async (page: number) => {
    // Reset to page 1 when applying new filters
    if (page < 1) page = 1;

    // Fetch products with the new page
    await getProducts({ page });
  };

  const featuredProducts = ref<Product[]>([]);

  const getFeaturedProducts = async () => {
    const response = await api<FeaturedProductsResponse>("/api/products/featured");

    featuredProducts.value = response.products;

    return response;
  };

  const currentProduct = ref<ProductDetails | null>(null);

  const getProductById = async (id: string) => {
    const response = await api<ProductResponse>(`/api/products/${id}`);

    currentProduct.value = response.product;

    return response;
  };

  return {
    products,
    getProducts,

    traits,
    getTraits,

    priceRange,
    setPriceRange,

    selectedTraits,
    toggleTraitValue,

    currentPage,
    totalProducts,
    itemsPerPage,
    setPage,

    featuredProducts,
    getFeaturedProducts,

    currentProduct,
    getProductById,
  };
});
