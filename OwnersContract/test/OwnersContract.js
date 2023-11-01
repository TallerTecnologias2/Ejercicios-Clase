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
      expect(await ownersContract.isOwner(owner.address)).to.be.true;
      expect(await ownersContract.isOwner(anotherAccount.address)).to.be.false;
    });
  });

  describe("Add Owners", function () {
    it("Owner can add another owner", async function () {
      const [owner, anotherAccount] = await ethers.getSigners()
      const ownersContract = await ethers.deployContract("OwnersContract", [], {});

      await ownersContract.addOwner(anotherAccount.address);
      
      expect(await ownersContract.isOwner(anotherAccount.address)).to.be.true;
    });

    it("Event is emitted", async function () {
      const [owner, anotherAccount] = await ethers.getSigners()
      const ownersContract = await ethers.deployContract("OwnersContract", [], {});

      await expect(ownersContract.addOwner(anotherAccount.address)).to
        .emit(ownersContract, "OwnerAdded")
        .withArgs(anotherAccount.address, owner.address);
    });

    it("Reject if no an owner", async function () {
      const [owner, anotherAccount] = await ethers.getSigners()
      const ownersContract = await ethers.deployContract("OwnersContract", [], {});

      const ownersContractSignedByAnotherAccount = ownersContract.connect(anotherAccount);
      await expect(ownersContractSignedByAnotherAccount.addOwner(anotherAccount.address)).to.be.rejectedWith("Not an Owner");
    });

    it("Reject if address 0", async function () {
      const ownersContract = await ethers.deployContract("OwnersContract", [], {});

      await expect(ownersContract.addOwner(ethers.constants.AddressZero)).to.be.rejectedWith("Invalid address");
    });

    it("Reject if already an owner", async function () {
      const [owner, anotherAccount] = await ethers.getSigners()
      const ownersContract = await ethers.deployContract("OwnersContract", [], {});

      await ownersContract.addOwner(anotherAccount.address);

      await expect(ownersContract.addOwner(anotherAccount.address)).to.be.rejectedWith("Already an Owner");
    });
  });

  describe("Is Owner", function () {
  });

  describe("Remove Owner", function () {
  });
});