const Oracle = artifacts.require("Oracle");
const FixedIncome = artifacts.require("FixedIncome");
const ERC20MultiFixedIncome = artifacts.require("ERC20MultiFixedIncome");

module.exports = async function (deployer) {
  const decimals = 2;
  await deployer.deploy(Oracle, reqURL, path, decimals);
};
