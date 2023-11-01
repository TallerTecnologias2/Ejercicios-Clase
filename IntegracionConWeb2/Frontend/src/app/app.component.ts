import { Component } from '@angular/core';

// Importar Ethers
import { ethers } from 'ethers';
declare global {
  interface Window {
    ethereum?: any
  }
}
const provider = new ethers.providers.Web3Provider(window.ethereum)
const contractAbi = [
  "function price() external pure returns(uint256)",
  "function mint(address _recipient) external payable"
]


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'Example Frontend';

  isConnected = false;
  price = 0;
  address = ''
  ERC20Contract: any | null = null

  async connectWallet() {
    // Conectar nuestra wallet
    await provider.send("eth_requestAccounts", []);
    
    // Obtener signer (nuestra wallet)
    const signer = provider.getSigner();
    this.address = await signer.getAddress();
    this.isConnected = true;

    // Creamos el contrato en base a la dirección, ABI y el signer
    this.ERC20Contract = new ethers.Contract("0x40e543cb946cd44abcad36281851a9fdd74e8f50", contractAbi, signer)
  }

  async getPrice() {
    if (!this.isConnected) {
      return;
    }

    this.price = await this.ERC20Contract.price();
  }

  async buyToken() {
    const tokensAComprar = 10;
    const weiaGastar = tokensAComprar * this.price;
    
    await this.ERC20Contract.mint(this.address, { value: weiaGastar});
  }

  priceText() {
    if (!this.isConnected) {
      return "Connect Wallet First";
    } else if (this.price == 0) {
      return "Update Price";
    }
    return `${this.price}`;
  }
}
