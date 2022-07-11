// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const [owner, addr1,addr2] = await hre.ethers.getSigners()
  
  const MoonPotion = await ethers.getContractFactory('MoonPotion')
  const moonpotion = await MoonPotion.deploy()
  await moonpotion.deployed()

  console.log(moonpotion.address)
  // txn = await domain.connect(addr1).setRecord("hii")
  // await txn.wait()
  // const ERC20 = await hre.ethers.getContractFactory("ERC20")
  // const erc20 = await hre.ethers.deploy("MyTokenl","MTN",1000,9)
  // await erc20.deployed()
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
