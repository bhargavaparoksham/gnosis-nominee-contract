const dotenv = require('dotenv').config()

const owner = process.env.OWNER
const avatar = process.env.AVATAR
const target = process.env.TARGET

module.exports = [
  owner,
  avatar,
  target,
];