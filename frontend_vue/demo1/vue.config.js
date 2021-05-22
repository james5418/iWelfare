module.exports = {
  devServer: {
    proxy: {
      "^/backend": {
        target: "http://localhost:8000",
        changeOrigin: true,
        pathRewrite: {
          "^/backend": "",
        },
      },
    },
  },
};
