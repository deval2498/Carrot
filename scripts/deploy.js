// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Greeter = await hre.ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, Hardhat!");

  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);
}

async function token() {
  const carrotWallet1 = "0xcbd7f493aa21058e9a8323d8b29ef89fbf3b8929";
  const carrotWallet2 = "0xd25A2363443bB9F3A830Ad525C13E75D52028d49";
  const amount = "1000000000000000000000000000000";
  const args = ["Carrot Coin", "CRTC", carrotWallet1, carrotWallet2, amount];
  const CarrotCoin = await hre.ethers.getContractFactory("CarrotCoin");
  const carrotcoin = await CarrotCoin.deploy(
    "Carrot Coin",
    "CRTC",
    "0xcbd7f493aa21058e9a8323d8b29ef89fbf3b8929",
    "0xd25A2363443bB9F3A830Ad525C13E75D52028d49",
    "1000000000000000000000000000000"
  );

  await carrotcoin.deployed();
  console.log("CRTC deployed at:", carrotcoin.address);
  console.log(
    "Verify at: npx hardhat verify --contract contracts/CarrotCoin.sol:CarrotCoin --network rinkeby",
    carrotcoin.address,
    args
  );
}

async function nft1155() {
  const carrotNFT = await hre.ethers.getContractFactory("CarrotNFT1155");
  const carrotnft = await carrotNFT.deploy();
  await carrotnft.deployed();
  console.log("Carrot NFT deployed at:", carrotnft.address);
  console.log(
    "Verify at; npx hardhat verify --contract contracts/CarrotNFT1155.sol:CarrotNFT --network rinkeby",
    carrotnft.address
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
//  token()
//    .then(() => process.exit(0))
//    .catch((error) => {
//      console.error(error);
//      process.exit(1);
//    });

nft1155()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
