module.exports = {
  devServer: {
    proxy: {
      "^/backend": {
        target: "http://localhost:3000",
        changeOrigin: true,
        pathRewrite: {
          "^/backend": "/api",
        },
      },
      "^/mysql": {
        target: "http://localhost:3000",
        changeOrigin: true,
        pathRewrite: {
          "^/mysql": "/dynamic",
        },
      },
    },
  },
};
