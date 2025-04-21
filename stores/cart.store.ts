import { defineStore } from "pinia";
import type { Product } from "~/server/utils/types";
import type { ProductsResponse } from "~/server/api/products.post";

// Define a cart item type with just ID and quantity
export type CartItem = {
  productId: string;
  quantity: number;
};

// Define a cart item with product data for display
export type CartProduct = {
  product: Product;
  quantity: number;
};

// LocalStorage key for cart data
const CART_STORAGE_KEY = "base-marketplace-cart";

export const useCartStore = defineStore("cart", () => {
  // Load cart data from localStorage if available
  const loadCartFromStorage = (): CartItem[] => {
    if (import.meta.client) {
      const storedCart = localStorage.getItem(CART_STORAGE_KEY);

      if (!storedCart) {
        return [];
      }

      try {
        return JSON.parse(storedCart);
      } catch (e) {
        console.error("Failed to parse cart data from localStorage", e);
      }
    }

    return [];
  };

  // Initialize cart with data from localStorage
  const cart = ref<CartItem[]>(loadCartFromStorage());

  // Save cart data to localStorage
  const saveCartToStorage = () => {
    if (import.meta.client) {
      localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(cart.value));
    }
  };

  // Watch for changes to cart and save to localStorage
  watch(
    cart,
    () => {
      saveCartToStorage();
    },
    { deep: true },
  );

  const cartProducts = computed<CartProduct[]>(() => {
    return cart.value
      .map(item => {
        const product = productsDataMap.value[item.productId];

        return {
          product,
          quantity: item.quantity,
        };
      })
      .filter(item => item.product);
  });

  const productsData = ref<Product[]>([]);
  const productsDataMap = computed(() => {
    return useKeyBy(productsData.value, "id");
  });

  const fetchCartProducts = async () => {
    if (!cart.value.length) {
      return;
    }

    const response = await api<ProductsResponse>("/api/products", {
      method: "POST",
      body: {
        id: cart.value.map(item => item.productId),
      },
    });

    productsData.value = response.products;

    return response;
  };

  const totalItems = computed(() => {
    return cartProducts.value.reduce((acc, item) => {
      return acc + item.quantity;
    }, 0);
  });

  const totalPrice = computed(() => {
    return cartProducts.value.reduce((acc, item) => {
      return acc + item.product.price * item.quantity;
    }, 0);
  });

  const addToCart = (productId: string) => {
    const foundProduct = cart.value.find(item => item.productId === productId);

    if (foundProduct) {
      foundProduct.quantity++;

      return;
    }

    cart.value.push({
      productId,
      quantity: 1,
    });
  };

  const removeFromCart = (productId: string) => {
    const foundIndex = cart.value.findIndex(item => item.productId === productId);

    if (foundIndex > -1) {
      cart.value.splice(foundIndex, 1);
    }
  };

  const updateQuantity = (productId: string, quantity: number) => {
    const foundProduct = cart.value.find(item => item.productId === productId);

    if (foundProduct) {
      foundProduct.quantity = quantity;
    }
  };

  const clearCart = () => {
    cart.value = [];
  };

  return {
    totalItems,
    totalPrice,
    cartProducts,

    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart,

    fetchCartProducts,
  };
});
