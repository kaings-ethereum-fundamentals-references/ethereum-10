pragma solidity ^0.8.0;

import '..//node_modules/@openzeppelin/contracts/token/ERC20/Extensions/ERC20Capped.sol';

contract MyToken is ERC20Capped {
    constructor() ERC20("mytoken", "MTK") ERC20Capped(100000) public {      // token is capped at 100K, exceeding the limit will throw an error
        _mint(msg.sender, 1000);        // e.g. refactoring to `_mint(msg.sender, 200000)`, it will throw an error 
    }
}