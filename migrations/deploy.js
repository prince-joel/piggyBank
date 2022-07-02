const PBANK = artifacts.require("PBANK");

module.exports = function (deployer) {
  deployer.deploy(PBANK);
};
