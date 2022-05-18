//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CarrotCoin is ERC20{
    constructor(string memory _name , string memory _symbol, address companyTreasury, address carrotApp, uint256 _amount) ERC20(_name, _symbol) {
            uint256 amount = _amount/2;
            _mint(companyTreasury, amount);
            _mint(carrotApp, amount);
    }
}