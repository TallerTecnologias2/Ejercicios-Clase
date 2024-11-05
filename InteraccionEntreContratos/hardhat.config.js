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
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};