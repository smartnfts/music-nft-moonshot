// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MusicNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    string private _baseURIextended;
    uint256 public maxSupply;

    constructor(
        string memory name,
        string memory symbol,
        string memory baseURI,
        uint256 _maxSupply
    ) ERC721(name, symbol) Ownable(msg.sender) {
        _baseURIextended = baseURI;
        maxSupply = _maxSupply;
    }

    function mintNFT(address recipient) public onlyOwner returns (uint256) {
        require(_tokenIds < maxSupply, "Max supply reached");
        _tokenIds += 1;
        uint256 newItemId = _tokenIds;
        _safeMint(recipient, newItemId);
        return newItemId;
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public onlyOwner {
        _setTokenURI(tokenId, tokenURI);
    }
    
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseURIextended = baseURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }

    function setMaxSupply(uint256 _maxSupply) public onlyOwner {
        maxSupply = _maxSupply;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds;
    }
}
