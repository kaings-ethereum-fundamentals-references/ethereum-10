const MyTokenV2 = artifacts.require("MyTokenV2");

module.exports = function (deployer) {
  deployer.deploy(MyTokenV2, "mytokenv2", "MTKV2", 100000);
};
