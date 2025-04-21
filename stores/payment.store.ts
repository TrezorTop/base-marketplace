import { defineStore } from "pinia";
import type { PaymentResponse } from "~/server/api/payment.get";

export const usePaymentStore = defineStore("payment", () => {
  const isProcessing = ref(false);

  // Payment result
  const paymentResult = ref<PaymentResponse | null>(null);

  // Process payment
  const processPayment = async (): Promise<PaymentResponse> => {
    isProcessing.value = true;

    try {
      // Call the payment API
      const response = await api<PaymentResponse>("/api/payment");

      // Store the result
      paymentResult.value = response;

      return response;
    } catch (error) {
      // Handle error
      console.error("Payment processing failed", error);

      const errorResponse: PaymentResponse = {
        success: false,
        message: "Payment processing failed. Please try again.",
      };

      paymentResult.value = errorResponse;
      return errorResponse;
    } finally {
      isProcessing.value = false;
    }
  };

  // Reset payment state
  const resetPayment = () => {
    paymentResult.value = null;
  };

  return {
    isProcessing,
    paymentResult,
    processPayment,
    resetPayment,
  };
});
