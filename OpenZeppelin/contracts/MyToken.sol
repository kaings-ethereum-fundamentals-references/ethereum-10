pragma solidity ^0.8.0;

import '../node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol';

contract MyToken is ERC20Capped {
    constructor() ERC20("mytoken", "MTK") ERC20Capped(100000) public {      // token is capped at 100K, exceeding the limit will throw an error
        
        // calling _mint function during construction will cause an error.
        // ref: https://forum.openzeppelin.com/t/erc20capped-immutable-variables-cannot-be-read-during-contract-creation-time/6174/3
        /*
        The thing is, ERC20Capped adds an extra check in the _mint function that verifies you are not exceeding the cap. 
        For efficiency reasons, we made the cap immutable. This removes a load operation when doing the check, and thus reduces the gas cost of minting. 
        The downside, as you show, is that this immutable variable cannot be read from during construction, which means you cannot use 
        ERC20Capped’s _mint protection during the construction.

        The good news is that the “non protected” ERC20._mint remains available!
        */

        // Therefore, this will cause an error
        // _mint(msg.sender, 1000);        // e.g. refactoring to `_mint(msg.sender, 200000)`, it will throw an error 

        // This will work though!
        ERC20._mint(msg.sender, 1000);
    }
}