var Users = artifacts.require("./Users.sol");
var Protocolo = artifacts.require("Protocolo");
var ProtocoloCentralFactory= artifacts.require("ProtocoloCentralFactory")


module.exports = function(deployer) {
   deployer.deploy(Protocolo);
   deployer.deploy(ProtocoloCentralFactory);
};
