require("@nomiclabs/hardhat-waffle");
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const POLYGONSCAN_API = process.env.POLYGONSCAN_API;
const POLYGON_RPC_URL = process.env.POLYGON_RPC_URL;
const ACCOUNT = process.env.WALLET_PRIVATE_KEY;
const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL;
module.exports = {
  solidity: "0.8.4",
  etherscan: {
    apiKey: "U6BGX85YA1EKJMM4YQ98ESJEPZ4FV79ETK",
  },
  networks: {
    polygon: {
      chainId: 137,
      url: POLYGON_RPC_URL,
      accounts: [ACCOUNT],
    },
    rinkeby: {
      chainId: 4,
      url: RINKEBY_RPC_URL,
      accounts: [ACCOUNT],
    },
  },
};
