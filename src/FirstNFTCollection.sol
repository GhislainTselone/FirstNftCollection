// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {console} from "forge-std/console.sol";

contract FirstNFTCollection is ERC721 {
    error FirstNFTCollection__TokenIdDoNotExist();

    address payable private immutable i_owner;

    /**
     * @notice To take count of the size of the collection
     * and also use it as direct tokenId
     */
    uint256 private s_tokenCounter;

    /**
     * @notice Associate the tokenId to the tokenURI here
     */
    mapping(uint256 => string) private s_tokenIdAndURI;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        i_owner = payable(msg.sender);
    }

    /**
     * @notice s_tokenCounter serves as the value of the tokenId
     * And as such the tokenIds will then be incremented
     * each times someone mint a new item in this collection
     */
    function minNft(string memory _tokenURI) public {
        console.log(msg.sender);
        s_tokenIdAndURI[s_tokenCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory _uri) {
        console.log(msg.sender);
        // Make sure to revert if the _tokenId exist
        if (ownerOf(_tokenId) == address(0)) {
            revert FirstNFTCollection__TokenIdDoNotExist();
        }
        return s_tokenIdAndURI[_tokenId];
    }

    receive() external payable {}

    fallback() external payable {}

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
