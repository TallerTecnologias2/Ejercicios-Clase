const { ethers } = require("hardhat");
const { expect } = require("chai");


describe("Marketplace", function () {

  describe("Deployment", function () {
    it("Test Deploy", async function () {
      await ethers.deployContract("Marketplace", [], {});
    });

    it("Should set deployer as owner", async function () {
      // Obtener otras cuentas para firmar
      const [owner, anotherAccount] = await ethers.getSigners()
      const marketplace = await ethers.deployContract("Marketplace", [], {});
      
      // Conectar a otra cuenta
      //ownersContract.connect(anotherAddress)
    });
  });

  describe("Buy Tokens", function () {
  });

  describe("Sell Tokens", function () {
  });

  describe("Change Price", function () {
  });
});