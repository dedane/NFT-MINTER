// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNft is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string[] firstWords = ["Chapati", "NyamaChoma", "Mutura", "Samosa"]
    string[] secondWords = ["Kanairo", "Chuom", "ChapoSmokie", "Thufu"]
    string[] thirdWords = ["Sheng", "Sosa", "Twende", "Kenya"]
    constructor () ERC721 ("SquareNft", "SQUARE"){
        console.log("This is my Nft");
    }
    
    //Pick a random words
    function pickARandomFirstWord(uint256 tokenId) public view returns(string memory) {

        uint256 rand = random(string(abi.encodedPacked("First Word",Strings.toString))))

        rand = rand % firstWords.length;
        return firstWords[rand];
    }
    ///function user will use to retrieve their NFT
    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        //Actually minting the nft
        _safeMint(msg.sender, newItemId);

        //Set Nfts Data
        _setTokenURI(newItemId, "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj4KICAgIDxzdHlsZT4uYmFzZSB7IGZpbGw6IHdoaXRlOyBmb250LWZhbWlseTogc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsgfTwvc3R5bGU+CiAgICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJibGFjayIgLz4KICAgIDx0ZXh0IHg9IjUwJSIgeT0iNTAlIiBjbGFzcz0iYmFzZSIgZG9taW5hbnQtYmFzZWxpbmU9Im1pZGRsZSIgdGV4dC1hbmNob3I9Im1pZGRsZSI+RXBpY0xvcmRNdXR1cmE8L3RleHQ+Cjwvc3ZnPg==");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        //Increment the counter for when next NFT is minted
        _tokenIds.increment();
    }

}