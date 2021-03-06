// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const dotenv = require('dotenv').config()

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  const owner = process.env.OWNER
  const avatar = process.env.AVATAR
  const target = process.env.TARGET

  // We get the contract to deploy
  const GnosisNominee = await hre.ethers.getContractFactory("GnosisNominee");
  const gnosisNominee = await GnosisNominee.deploy(owner,avatar,target);

  await gnosisNominee.deployed();

  console.log("GnosisNominee deployed to:", gnosisNominee.address);

  //gnosisNominee rinkeby address v0: 0xcF22faaDF8e984149E7a80dD4D7C14381471cf3D
  //gnosisNominee rinkeby address v1: 0x5973694d415645D68e83A2144E85DB100cA77b9E --> Works
  //gnosisNominee rinkeby address v2: 0xE6833D8d1df818535A1E5eC31Ec43306D860AF45
  //gnosisNominee rinkeby address test contract with test functions: 0xE9F35d3c958c1C770693a2e4927E5A6fc4025238
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });


