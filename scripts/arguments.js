const dotenv = require('dotenv').config()

const owner = process.env.OWNER
const avatar = process.env.AVATAR
const target = process.env.TARGET

module.exports = [
  owner,
  avatar,
  target,
];


// npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"

//npx hardhat verify --constructor-args arguments.js DEPLOYED_CONTRACT_ADDRESS