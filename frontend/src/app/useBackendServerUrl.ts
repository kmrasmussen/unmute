export const useBackendServerUrl = () => {
  if (process.env.NEXT_PUBLIC_BACKEND_SERVER_URL) {
    return process.env.NEXT_PUBLIC_BACKEND_SERVER_URL;
  }
  if (process.env.NODE_ENV === "development") {
    return "http://localhost:8000";
  }
  return "http://193.183.22.55:1660";
};