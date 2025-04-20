<script setup lang="ts">
import { useCategoriesStore } from "~/stores/categories.store";
import { watchDebounced } from "#imports";
import { FETCH_DEBOUNCE } from "~/consts/fetch-debounce";

const productsStore = useProductsStore();
const categoriesStore = useCategoriesStore();

// Function to get category IDs from selected category names
const getSelectedCategoryIds = () => {
  if (categoriesStore.selectedCategories.length === 0) {
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

// Price range filter
const minPrice = ref<number | undefined>();
const maxPrice = ref<number | undefined>();

const applyPriceFilter = () => {
  productsStore.setPriceRange(minPrice.value, maxPrice.value);
};

// Get traits for selected categories only when categories are selected
const visibleTraits = computed(() => {
  if (categoriesStore.selectedCategories.length === 0) {
    return []; // Return empty array when no categories selected
  }

  return productsStore.traits.filter(categoryTrait =>
    categoriesStore.selectedCategories.includes(categoryTrait.category.name),
  );
});

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

  if (values.length === 0) {
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
    <!-- Price filter -->
    <div class="mb-6">
      <h3 class="text-lg font-medium mb-2">Price Range</h3>
      <div class="flex items-center gap-2">
        <UInput v-model="minPrice" type="number" placeholder="Min" class="w-24" />
        <span>to</span>
        <UInput v-model="maxPrice" type="number" placeholder="Max" class="w-24" />
        <UButton size="sm" @click="applyPriceFilter">Apply</UButton>
      </div>
    </div>

    <!-- Traits filters - only shown when categories are selected -->
    <div v-if="categoriesStore.selectedCategories.length > 0">
      <div v-for="categoryTrait in visibleTraits" :key="categoryTrait.category.id" class="mb-6">
        <h3 class="text-lg font-medium mb-2">{{ categoryTrait.category.title }}</h3>

        <div class="flex flex-wrap gap-3">
          <div v-for="trait in categoryTrait.traits" :key="trait.name" class="mb-2 mr-2">
            <h4 class="font-medium mb-1">{{ trait.title }}</h4>

            <USelect
              :items="trait.values"
              multiple
              placeholder="Select values"
              @update:model-value="
                handleTraitValueChange(categoryTrait.category.id, trait.name, $event)
              "
              :model-value="getSelectedValues(categoryTrait.category.id, trait.name)"
            />
          </div>
        </div>
      </div>
    </div>

    <!-- Message when no categories are selected -->
    <div v-else class="mb-6 text-gray-500">
      Please select at least one category to see available traits.
    </div>
  </div>
</template>

<style scoped></style>
