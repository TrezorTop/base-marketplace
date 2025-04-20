import { createError, defineEventHandler } from "h3";
import db from "~/server/utils/db";

export type Category = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  title: string;
};

export type CategoriesResponse = {
  categories: Category[];
};

export default defineEventHandler(async (event): Promise<CategoriesResponse> => {
  try {
    const categories = await db.category.findMany();

    return {
      categories,
    };
  } catch (error) {
    console.error("Error fetching categories:", error);

    throw createError({
      statusCode: 500,
      statusMessage: "Failed to fetch categories",
    });
  }
});
