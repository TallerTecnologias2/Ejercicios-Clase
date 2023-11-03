const { ethers } = require("hardhat");
const { expect } = require("chai");


describe("Marketplace", function () {

  describe("Deployment", function () {
    it("Should set deployer as owner", async function () {
      const [owner] = await ethers.getSigners()
      const marketplace = await ethers.deployContract("Marketplace", [1, owner.address], {});

      expect(await marketplace.owner()).to.be.equal(owner.address);
    });
  });

  describe("Buy Tokens", function () {
    it("Fails if amount is 0", async function() {
      const [owner] = await ethers.getSigners()
      const marketplace = await ethers.deployContract("Marketplace", [1, owner.address], {});
      
      await expect(marketplace.buyToken(0)).to.be.rejectedWith("Invalid amount");
    });

    it("Fails if value is not enough", async function() {
      const [owner] = await ethers.getSigners()
      const marketplace = await ethers.deployContract("Marketplace", [1, owner.address], {});
      
      await expect(marketplace.buyToken(19, { value: 1 })).to.be.rejectedWith("Insufficient ETH");
    });

    it("Fails if contract doesnt have enough tokens", async function() {
      const token = await ethers.deployContract("Token", ["Token", "ORT", 1000], {});
      const marketplace = await ethers.deployContract("Marketplace", [1, token.address], {});
      
      await expect(marketplace.buyToken(10, { value: 10 })).to.be.rejectedWith("Contract doesn't have enough tokens");
    });

    it("Success", async function() {
      const [owner] = await ethers.getSigners()
      const token = await ethers.deployContract("Token", ["Token", "ORT", 1000], {});
      const marketplace = await ethers.deployContract("Marketplace", [1, token.address], {});
      await token.setMarketplaceAddress(marketplace.address);
      await token.mint(100)

      await expect(marketplace.buyToken(10, { value: 10 })).to.changeTokenBalances(
        token,
        [marketplace, owner],
        [-10, 10]
      );
    });
  });

  describe("Sell Tokens", function () {
    it("Fails if amount is 0", async function() {
      const [owner] = await ethers.getSigners()
      const token = await ethers.deployContract("Token", ["Token", "ORT", 1000], {});
      const marketplace = await ethers.deployContract("Marketplace", [1, token.address], {});
      await token.setMarketplaceAddress(marketplace.address);
      await token.mint(100)

      await expect(marketplace.sellToken(0)).to.be.rejectedWith("Invalid amount");
    });

    it("Fails if not enough allowance", async function() {
      const [owner] = await ethers.getSigners()
      const token = await ethers.deployContract("Token", ["Token", "ORT", 1000], {});
      const marketplace = await ethers.deployContract("Marketplace", [1, token.address], {});
      await token.setMarketplaceAddress(marketplace.address);
      await token.mint(100)

      await expect(marketplace.sellToken(10)).to.be.rejectedWith("Insufficient allowance");
    });

    it("Success", async function() {
      const [owner] = await ethers.getSigners()
      const token = await ethers.deployContract("Token", ["Token", "ORT", 1000], {});
      const marketplace = await ethers.deployContract("Marketplace", [1, token.address], {});
      await token.setMarketplaceAddress(marketplace.address);
      await token.mint(100)

      await marketplace.buyToken(10, { value: 10 })
      await token.approve(marketplace.address, 10)

      await expect(marketplace.sellToken(4)).to.changeTokenBalances(
        token,
        [owner, marketplace],
        [-4, 4]
      );

      await expect(marketplace.sellToken(6)).to.changeEtherBalances(
        [owner, marketplace],
        [2, -2]
      );
    });
  });
});