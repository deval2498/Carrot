//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract CarrotNFT is ERC721, Ownable, ERC721URIStorage {
    string public baseURI;
    uint256 private currentId = 1;
    address private gnosisSafe = 0xd25A2363443bB9F3A830Ad525C13E75D52028d49;
    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol) {

    }
    event minted(uint256 indexed tokenId,string tokenURI);
    event URIChanged(string _baseURI);
    
    function batchTransfer(address[] memory receivers, uint256[] memory _tokenId) external {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        require(receivers.length == _tokenId.length, 'receivers and ids dont match!');
        for(uint256 i = 0; i < receivers.length; i ++)
        {
            _transfer(msg.sender, receivers[i], _tokenId[i]);
        }
    }
    function batchMint(uint256 amount) external  {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        for(uint256 i = 0;i < amount ; i++){
            _mint(msg.sender, currentId);
            emit minted(i,tokenURI(currentId));
            ++currentId;
            
        }
    }
    function setBaseURI(string memory newBaseURI) external {
        require(msg.sender == gnosisSafe, "Transaction not initiated by safe wallet");
        baseURI = newBaseURI;
        emit URIChanged(newBaseURI);
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}