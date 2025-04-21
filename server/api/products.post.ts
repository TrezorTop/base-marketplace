import { createError, defineEventHandler, readBody } from "h3";
import db from "~/server/utils/db";
import type { Prisma } from "~/prisma/generated/prisma";
import type { Product } from "~/server/utils/types";

export type ProductsResponse = {
  products: Product[];
  total: number;
};

export type ProductsFilter = {
  price?: {
    min?: number;
    max?: number;
  };
  id?: string[];
  categoryId?: string[];
  traits?: {
    categoryId: string;
    name: string;
    values: string[];
  }[];
  sort?: {
    field: string;
    direction: "asc" | "desc";
  };
  page?: number;
  limit?: number;
};

export default defineEventHandler(async (event): Promise<ProductsResponse> => {
  try {
    const filter = (await readBody<ProductsFilter>(event)) || {};

    // Build the where clause for the query
    const where: Prisma.ProductWhereInput = {};

    // Filter by price
    if (filter.price) {
      if (filter.price.min) {
        where.price = {
          ...(where.price as object),
          gte: filter.price.min,
        };
      }

      if (filter.price.max) {
        where.price = {
          ...(where.price as object),
          lte: filter.price.max,
        };
      }
    }

    // Filter by id
    if (filter.id && filter.id.length > 0) {
      where.id = {
        in: filter.id,
      };
    }

    // Filter by categoryId
    if (filter.categoryId && filter.categoryId.length > 0) {
      where.categoryId = {
        in: filter.categoryId,
      };
    }

    // Filter by traits
    if (filter.traits && filter.traits.length > 0) {
      // Group traits by categoryId
      const traitsByCategory: Record<string, Array<{ name: string; values: string[] }>> = {};

      for (const trait of filter.traits) {
        if (trait.values.length > 0) {
          if (!traitsByCategory[trait.categoryId]) {
            traitsByCategory[trait.categoryId] = [];
          }
          traitsByCategory[trait.categoryId].push({
            name: trait.name,
            values: trait.values,
          });
        }
      }

      // Create filters for each category
      const categoryTraitFilters: Prisma.ProductWhereInput[] = [];

      for (const [categoryId, traits] of Object.entries(traitsByCategory)) {
        const categoryFilter: Prisma.ProductWhereInput = {
          categoryId,
          AND: [],
        };

        // Add each trait as an AND condition within this category
        for (const trait of traits) {
          // Create a filter for each possible trait value (OR condition)
          const valueFilters = trait.values.map(value => ({
            traits: {
              path: [trait.name, "value"],
              equals: value,
            },
          }));

          (categoryFilter.AND as Prisma.ProductWhereInput[]).push({ OR: valueFilters });
        }

        categoryTraitFilters.push(categoryFilter);
      }

      // If we have category filters, add them to the where clause
      if (categoryTraitFilters.length > 0) {
        // If we already have a categoryId filter, we need to combine it with our trait filters
        if (where.categoryId) {
          // Create an OR condition that includes both:
          // 1. Products that match our category-trait filters
          // 2. Products that match the categoryId filter but don't have trait filters for that category
          const categoryIds = Object.keys(traitsByCategory);
          const categoriesWithoutTraits = (where.categoryId as Prisma.UuidFilter).in?.filter(
            (id: string) => !categoryIds.includes(id),
          );

          const orConditions: Prisma.ProductWhereInput[] = [...categoryTraitFilters];

          if (categoriesWithoutTraits?.length || 0 > 0) {
            orConditions.push({
              categoryId: {
                in: categoriesWithoutTraits,
              },
            });
          }

          // Replace the categoryId filter with our OR condition
          delete where.categoryId;
          where.OR = orConditions;
        } else {
          // If no categoryId filter exists, just use OR for our category-trait filters
          where.OR = categoryTraitFilters;
        }
      }
    }

    // Build the orderBy clause for sorting
    let orderBy = undefined;

    if (filter.sort) {
      // Create a dynamic orderBy object based on the field and direction
      orderBy = {
        [filter.sort.field]: filter.sort.direction,
      };
    }

    // Default pagination values
    const page = filter.page || 1;
    const limit = filter.limit || 10;
    const skip = (page - 1) * limit;

    // Get products with pagination
    const products = await db.product.findMany({
      where,
      orderBy,
      skip,
      take: limit,
    });

    // Get total count of products matching the filter
    const total = await db.product.count({ where });

    return {
      products: products as Product[],
      total,
    };
  } catch (error) {
    console.error("Error fetching products:", error);

    throw createError({
      statusCode: 500,
      statusMessage: "Failed to fetch products",
    });
  }
});
