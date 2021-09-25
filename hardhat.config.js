require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

const dotenv = require('dotenv').config()
const infuraTestnet = process.env.RINKEBY
const infuraMainnet = process.env.MAINNET
const privateKey = process.env.PRIVATE_KEY_1
const etherscanKey = process.env.ETHERSCAN_KEY

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {
    },
    rinkeby: {
      url: infuraTestnet,
      accounts: [privateKey]
    },
    mainnet: {
      url: infuraMainnet,
      accounts: [privateKey]
    }
  },
  solidity: {
    version: "0.8.6",
    settings: {
      optimizer: {
        enabled: false,
        runs: 200
      }
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: etherscanKey
  }

};
