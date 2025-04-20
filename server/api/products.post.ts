import { createError, defineEventHandler, readBody } from "h3";
import db from "~/server/utils/db";
import { Prisma } from "~/prisma/generated/prisma";

export type Product = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  description: string;
  price: number;
  categoryId: string;
  traits: Prisma.JsonValue;
};

export type ProductsResponse = {
  products: Product[];
  total: number;
};

export type ProductsFilter = {
  price?: {
    min?: number;
    max?: number;
  };
  categoryId?: string[];
  traits?: {
    categoryId: string;
    name: string;
    values: string[];
  }[];
  sort?: {
    field: string;
    direction: 'asc' | 'desc';
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

    // Filter by categoryId
    if (filter.categoryId && filter.categoryId.length > 0) {
      where.categoryId = {
        in: filter.categoryId,
      };
    }

    // Filter by traits
    if (filter.traits && filter.traits.length > 0) {
      // For each trait, we need to check if the product's traits JSON contains the specified values
      const traitFilters: Prisma.ProductWhereInput[] = [];

      for (const trait of filter.traits) {
        if (trait.values.length > 0) {
          // Create a filter for each possible trait value (OR condition)
          const valueFilters = trait.values.map(value => ({
            traits: {
              path: [trait.name],
              equals: value,
            },
          }));

          traitFilters.push({
            AND: [{ categoryId: trait.categoryId }, { OR: valueFilters }],
          });
        }
      }

      // Combine all trait filters with AND (product must match all specified traits)
      if (traitFilters.length > 0) {
        where.AND = (where.AND as Prisma.ProductWhereInput[]) || [];
        where.AND.push(...traitFilters);
      }
    }

    // Build the orderBy clause for sorting
    let orderBy = undefined;

    if (filter.sort) {
      // Create a dynamic orderBy object based on the field and direction
      orderBy = {
        [filter.sort.field]: filter.sort.direction
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
      products,
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
