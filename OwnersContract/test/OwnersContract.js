const { ethers } = require("hardhat");
const { expect } = require("chai");


describe("OwnersContract", function () {

  describe("Deployment", function () {
    it("Test Deploy", async function () {
      await ethers.deployContract("OwnersContract", [], {});
    });

    it("Should set deployer as owner", async function () {
      // Obtener otras cuentas para firmar
      const [owner, anotherAccount] = await ethers.getSigners()
      const ownersContract = await ethers.deployContract("OwnersContract", [], {});
      
      // Conectar a otra cuenta
      //ownersContract.connect(anotherAddress)
    });
  });

  describe("Add Owners", function () {
  });

  describe("Is Owner", function () {
  });

  describe("Remove Owner", function () {
  });
});