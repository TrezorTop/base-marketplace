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
  traits: Record<string, TraitDetails>;
  image?: string; // Optional image path or filename
};

export type ProductDetails = {
  id: string;
  createdAt: Date;
  updatedAt: Date;
  name: string;
  description: string;
  price: number;
  categoryId: string;
  traits: Record<string, TraitDetails>;
  image?: string; // Optional image path or filename
  category: Category;
};
