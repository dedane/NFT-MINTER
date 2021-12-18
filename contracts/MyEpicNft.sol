// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNft is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    constructor () ERC721 ("SquareNft", "SQUARE"){
        console.log("This is my Nft");
    }

    ///function user will use to retrieve their NFT
    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        //Actually minting the nft
        _safeMint(msg.sender, newItemId);

        //Set Nfts Data
        _setTokenURI(newItemId, "FirstNFT");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        //Increment the counter for when next NFT is minted
        _tokenIds.increment();
    }

}