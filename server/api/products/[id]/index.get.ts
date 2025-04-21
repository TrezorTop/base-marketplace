import { createError, defineEventHandler } from "h3";
import db from "~/server/utils/db";
import type { ProductDetails } from "~/server/utils/types";

export type ProductResponse = {
  product: ProductDetails | null;
};

export default defineEventHandler(async (event): Promise<ProductResponse> => {
  try {
    const id = event.context.params?.id;

    if (!id) {
      throw createError({
        statusCode: 400,
        statusMessage: "Product ID is required",
      });
    }

    const product = await db.product.findUnique({
      where: {
        id: id,
      },
      include: {
        category: true,
      },
    });

    if (!product) {
      throw createError({
        statusCode: 404,
        statusMessage: "Product not found",
      });
    }

    return {
      product: product as ProductDetails,
    };
  } catch (error) {
    console.error(`Error fetching product details:`, error);

    throw createError({
      statusCode: 500,
      statusMessage: "Failed to fetch product details",
    });
  }
});
