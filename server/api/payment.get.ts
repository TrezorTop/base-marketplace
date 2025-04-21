import { defineEventHandler } from "h3";

export type PaymentResponse = {
  success: boolean;
  message: string;
};

export default defineEventHandler(async (): Promise<PaymentResponse> => {
  // Wait for 5 seconds to mock payment processing
  await new Promise((resolve) => setTimeout(resolve, 2500));
  
  // Return success response
  return {
    success: true,
    message: "Payment processed successfully",
  };
});