const crowdsale = artifacts.require("Crowdsale"); //artifacts.require specify deployment contract
const token = artifacts.require("AdyboseCrowdsaleERC20Detailed"); //artifacts.require specify deployment contract

module.exports = async function(deployer) {
       await  deployer.deploy(token, 'Adybose Token', 'ABT', 1000000);
       console.log('My Crowdsale token Adybose Token, symbol ABT at:', token.address);

       await  deployer.deploy(crowdsale, 1, 'lat13u5xqwvdzfpzhdfl8daksy66ssss9tp0fknchz', token.address);
       console.log('My Crowdsale contract at:', crowdsale.address);
};