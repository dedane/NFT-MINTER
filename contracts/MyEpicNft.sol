// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNft is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = ["Chapati", "NyamaChoma", "Mutura", "Samosa"];
    string[] secondWords = ["Kanairo", "Chuom", "ChapoSmokie", "Thufu"];
    string[] thirdWords = ["Sheng", "Sosa", "Twende", "Kenya"];
    constructor () ERC721 ("SquareNft", "SQUARE"){
        console.log("This is my Nft");
    }
    
    //Pick a random words from first array
    function pickRandomFirstWord(uint256 tokenId) public view returns(string memory) {

       uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
       rand = rand % firstWords.length;
       return firstWords[rand];
    }
    //Picks random word from second array
    function pickRandomSecondWord(uint256 tokenId) public view returns(string memory) {

       uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
       rand = rand % secondWords.length;
       return secondWords[rand];
    }
    // Picks a random word from third array
    function pickRandomThirdWord(uint256 tokenId) public view returns(string memory) {

       uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
       rand = rand % thirdWords.length;
       return thirdWords[rand];
    }

     function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

    


    ///function user will use to retrieve their NFT
    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        //Stores all the random words generated in all arrays in different memory variables
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
         string memory combinedWord = string(abi.encodePacked(first, second, third));

        // Mixes random words from all the arrays to produce one word and uses base svg to display them
        string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));
        event NewEpicNFTMinted(address sender, uint256 tokenId);

        // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    combinedWord,
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");
        //Actually minting the nft
        _safeMint(msg.sender, newItemId);

        //Set Nfts Data
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        //Increment the counter for when next NFT is minted
        emit NewEpicNFTMinted(msg.sender, newItemId);
    }

}