import { Prisma } from "~/prisma/generated/prisma";

export type TraitValue = string[];

export type TraitDetails = {
  name: string;
  title: string;
  value: string;
};

export type Trait = {
  name: string;
  title: string;
  values: TraitValue;
};

export type Category = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  title: string;
};

export type Product = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  description: string;
  price: number;
  categoryId: string;
  traits: Prisma.JsonValue | Record<string, TraitDetails>;
};

export type ProductDetails = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  description: string;
  price: number;
  categoryId: string;
  traits: Prisma.JsonValue | Record<string, TraitDetails>;
  category: Category;
};
