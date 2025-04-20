import { createError, defineEventHandler, readBody } from "h3";
import db from "~/server/utils/db";

export type TraitValue = string[];

export type Trait = {
  name: string;
  title: string;
  values: TraitValue;
};

export type CategoryTrait = {
  category: {
    id: string;
    name: string;
    title: string;
  };
  traits: Trait[];
};

export type TraitsResponse = {
  traits: CategoryTrait[];
};

export type TraitsRequest = {
  categoryIds?: string[];
};

export default defineEventHandler(async (event): Promise<TraitsResponse> => {
  try {
    // Get category IDs from request body
    const body = await readBody<TraitsRequest>(event);
    const categoryIds = body.categoryIds || [];

    // If no category IDs provided, return empty response
    if (categoryIds.length === 0) {
      return { traits: [] };
    }

    // Fetch categories with their traits and products in a single query
    const categories = await db.category.findMany({
      where: {
        id: {
          in: categoryIds,
        },
      },
      select: {
        id: true,
        title: true,
        name: true,
        traits: {
          select: {
            name: true,
            title: true,
          },
        },
        products: {
          select: {
            traits: true,
          },
        },
      },
    });

    const response = categories.map(category => {
      // Create a map to store trait titles by name for quick lookup
      const traitTitleMap = new Map<string, string>();
      category.traits.forEach(trait => {
        traitTitleMap.set(trait.name, trait.title);
      });

      // Get unique trait names for this category
      const traitNames = [...new Set(category.traits.map(trait => trait.name))];

      // Build traits array for this category
      const traitsArray = traitNames.map(traitName => {
        // Extract all values for this trait from products
        const values = category.products
          .map(product => (product.traits as Record<string, string>)[traitName])
          .filter(Boolean); // Filter out undefined/null values

        // Store unique, sorted values
        const uniqueValues = [...new Set(values)].sort();

        return {
          name: traitName,
          title: traitTitleMap.get(traitName) || traitName, // Fallback to name if title not found
          values: uniqueValues,
        };
      });

      return {
        category: {
          id: category.id,
          name: category.name,
          title: category.title,
        },
        traits: traitsArray,
      };
    });

    return {
      traits: response,
    };
  } catch (error) {
    console.error("Error fetching traits:", error);

    throw createError({
      statusCode: 500,
      statusMessage: "Failed to fetch traits",
    });
  }
});
