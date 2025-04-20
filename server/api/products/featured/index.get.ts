import { createError, defineEventHandler } from "h3";
import type { Product } from "~/server/utils/types";

const FEAUTED_PRODUCTS_IDS = [
  "a1b2c3d4-e5f6-7890-abcd-123456789004",
  "a1b2c3d4-e5f6-7890-abcd-123456789016",
  "a1b2c3d4-e5f6-7890-abcd-123456789003",
];

export type FeaturedProductsResponse = {
  products: Product[];
};

export default defineEventHandler(async (): Promise<FeaturedProductsResponse> => {
  try {
    const products = await db.product.findMany({
      where: {
        id: {
          in: FEAUTED_PRODUCTS_IDS,
        },
      },
    });

    return {
      products,
    };
  } catch (error) {
    console.error("Error fetching featured products:", error);

    throw createError({
      statusCode: 500,
      statusMessage: "Failed to fetch featured products",
    });
  }
});
