require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.20",
  networks: {
    mumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: ["YOUR_PRIVATE_KEY"]
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      accounts: ["YOUR_PRIVATE_KEY"]
    }
  }
};
