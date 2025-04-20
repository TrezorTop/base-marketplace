const api = $fetch.create({
  baseURL: process.env.API_BASE_URL || "http://localhost:3000/",
});

export default api;
