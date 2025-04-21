import { createError, defineEventHandler, readBody } from "h3";
import db from "~/server/utils/db";
import type { Trait, TraitDetails } from "~/server/utils/types";

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
    if (!categoryIds.length) {
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

    // If no categories are found, this will be an empty array
    const response = categories.map(category => {
      // Create a map to store trait titles by name for quick lookup
      const traitTitleMap = new Map<string, string>();
      category.traits.forEach(trait => {
        traitTitleMap.set(trait.name, trait.title);
      });

      // Get unique trait names for this category
      // If a category has no traits, this will be an empty array
      const traitNames = [...new Set(category.traits.map(trait => trait.name))];

      // Build traits array for this category
      const traitsArray = traitNames.map(traitName => {
        // Extract all values for this trait from products
        const values = category.products
          .map(product => {
            try {
              const traits = product.traits as Record<string, TraitDetails>;
              const traitDetail = traits[traitName];
              return traitDetail ? traitDetail.value : undefined;
            } catch (error) {
              console.error(`Error processing trait ${traitName} for product:`, error);
              return undefined;
            }
          })
          .filter(Boolean); // Filter out undefined/null values

        // Store unique, sorted values
        const uniqueValues = values.length > 0 ? [...new Set(values)].sort() : [];

        return {
          name: traitName,
          title: traitTitleMap.get(traitName) || traitName,
          values: uniqueValues as string[],
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
