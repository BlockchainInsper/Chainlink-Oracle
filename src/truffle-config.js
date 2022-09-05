const HDWalletProvider = require("@truffle/hdwallet-provider");
const nodeUrl = "https://rinkeby.infura.io/v3/e72e52471a414e1cbaaeaa3c60763693"
module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    },
    //INSERT YOUR PK
    rinkeby: {
      provider: () => new HDWalletProvider("PK", nodeUrl),
      network_id: 4,
      gas: 600000000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      gasPrice: 100000000000,
    },
  },
  compilers: {
    solc: {
      version: "0.8.7",
    }
  }
}