// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract CarrotNFT1155 is ERC1155, Ownable, Pausable, ERC1155Burnable, ERC1155Supply {
    address private gnosisSafe = 0xd25A2363443bB9F3A830Ad525C13E75D52028d49;
    constructor() ERC1155("") {}

    function setURI(string memory newuri) public {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        _setURI(newuri);
    }

    function pause() public {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        _pause();
    }

    function unpause() public {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        _unpause();
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
    {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        internal
        whenNotPaused
        override(ERC1155, ERC1155Supply)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}