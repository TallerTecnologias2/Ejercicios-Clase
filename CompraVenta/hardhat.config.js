require('dotenv').config();
require('@nomiclabs/hardhat-ethers');
require('solidity-coverage');
require('hardhat-contract-sizer');
require("@nomicfoundation/hardhat-chai-matchers");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.16",
  // Agregar ganache aca, y todas las cuentas que necesiten
  networks: {
    ganache: {
      url: "http://127.0.0.1:7545",
      accounts: [
        `0xa41f057960fdfe8d318a066636c5636e1fae9c847e032826b774a76034cfde2d`,
      ],
    },
    sepolia: {
      // Pueden poner su API KEY en el .env
      url: "https://sepolia.infura.io/v3/"+process.env.API_KEY,
      accounts: [
        // Pueden poner su clave privada en el archivo .env y no commitear el mismo
        process.env.PRIVATE_KEY,
      ],
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};