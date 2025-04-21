<script setup lang="ts">
import { useCategoriesStore } from "~/stores/categories.store";
import { useProductsStore } from "~/stores/products.store";
import { FETCH_DEBOUNCE } from "~/consts/fetch-debounce";

const productsStore = useProductsStore();
const categoriesStore = useCategoriesStore();

enum SortingOptions {
  Nothing = "Nothing",
  PriceAsc = "PriceAsc",
  PriceDesc = "PriceDesc",
  NameAsc = "NameAsc",
  NameDesc = "NameDesc",
  Newest = "Newest",
  Oldest = "Oldest",
}

const sortOptionsMap: Record<
  SortingOptions,
  { field: string | null; direction: "asc" | "desc" | null }
> = {
  [SortingOptions.Nothing]: { field: null, direction: null },
  [SortingOptions.PriceAsc]: { field: "price", direction: "asc" },
  [SortingOptions.PriceDesc]: { field: "price", direction: "desc" },
  [SortingOptions.NameAsc]: { field: "name", direction: "asc" },
  [SortingOptions.NameDesc]: { field: "name", direction: "desc" },
  [SortingOptions.Newest]: { field: "createdAt", direction: "desc" },
  [SortingOptions.Oldest]: { field: "createdAt", direction: "asc" },
};

const sortOptions = [
  { label: "Nothing", value: SortingOptions.Nothing },
  { label: "Price: Low to High", value: SortingOptions.PriceAsc },
  { label: "Price: High to Low", value: SortingOptions.PriceDesc },
  { label: "Name: A to Z", value: SortingOptions.NameAsc },
  { label: "Name: Z to A", value: SortingOptions.NameDesc },
  { label: "Newest", value: SortingOptions.Newest },
  { label: "Oldest", value: SortingOptions.Oldest },
];

// Handle sort change
const handleSortChange = (option: SortingOptions) => {
  if (option) {
    const sortMapping = sortOptionsMap[option];
    productsStore.setSorting(sortMapping.field, sortMapping.direction);
  }
};

const currentSortOption = ref<SortingOptions | undefined>();

// Function to get category IDs from selected category names
const getSelectedCategoryIds = () => {
  if (!categoriesStore.selectedCategories.length) {
    return [];
  }

  return categoriesStore.categories
    .filter(category => categoriesStore.selectedCategories.includes(category.name))
    .map(category => category.id);
};

// Watch for changes in categories and selected categories to fetch traits
watchDebounced(
  categoriesStore.selectedCategories,
  async () => {
    const categoryIds = getSelectedCategoryIds();

    await productsStore.getTraits(categoryIds);
  },
  { immediate: true, debounce: FETCH_DEBOUNCE },
);

const minPrice = ref<number | undefined>();
const maxPrice = ref<number | undefined>();

const applyPriceFilter = () => {
  productsStore.setPriceRange(minPrice.value, maxPrice.value);
};

// Get selected values for a trait
const getSelectedValues = (categoryId: string, traitName: string) => {
  const trait = productsStore.selectedTraits.find(
    t => t.categoryId === categoryId && t.name === traitName,
  );
  return trait?.values || [];
};

// Handle trait value selection changes
const handleTraitValueChange = (categoryId: string, traitName: string, values: string[]) => {
  // Find if we already have this trait in the array
  const traitIndex = productsStore.selectedTraits.findIndex(
    trait => trait.categoryId === categoryId && trait.name === traitName,
  );

  if (!values.length) {
    // If no values selected, remove the trait if it exists
    if (traitIndex !== -1) {
      productsStore.selectedTraits.splice(traitIndex, 1);
    }
  } else if (traitIndex === -1) {
    // Trait not found, add it with the values
    productsStore.selectedTraits.push({
      categoryId,
      name: traitName,
      values,
    });
  } else {
    // Update existing trait values
    productsStore.selectedTraits[traitIndex].values = values;
  }
};
</script>

<template>
  <div>
    <div class="mb-6">
      <div class="flex justify-between items-center">
        <div>
          <h3 class="text-lg font-medium mb-2">Price Range</h3>

          <div class="flex items-center gap-2">
            <UInput v-model="minPrice" type="number" placeholder="Min" class="w-24" />
            <span>to</span>
            <UInput v-model="maxPrice" type="number" placeholder="Max" class="w-24" />
            <UButton size="sm" @click="applyPriceFilter">Apply</UButton>
          </div>
        </div>

        <div>
          <h3 class="text-lg font-medium mb-2">Sort By</h3>
          <USelect
            :items="sortOptions"
            placeholder="Select sorting"
            :model-value="currentSortOption"
            class="w-48"
            :content="{
              bodyLock: false,
            }"
            @update:model-value="handleSortChange($event)"
          />
        </div>
      </div>
    </div>

    <template v-if="productsStore.traits.length">
      <div
        v-for="categoryTrait in productsStore.traits"
        :key="categoryTrait.category.id"
        class="mb-6"
      >
        <h3 class="text-lg font-medium mb-2">{{ categoryTrait.category.title }}</h3>

        <div class="flex flex-wrap gap-3">
          <div v-for="trait in categoryTrait.traits" :key="trait.name" class="mb-2 mr-2">
            <h4 class="font-medium mb-1">{{ trait.title }}</h4>

            <USelect
              :items="trait.values"
              multiple
              placeholder="Select values"
              :model-value="getSelectedValues(categoryTrait.category.id, trait.name)"
              :content="{
                bodyLock: false,
              }"
              @update:model-value="
                handleTraitValueChange(categoryTrait.category.id, trait.name, $event)
              "
            />
          </div>
        </div>
      </div>
    </template>

    <div v-else class="mb-6 text-gray-500">
      Please select at least one category to see available traits.
    </div>
  </div>
</template>

<style scoped></style>
