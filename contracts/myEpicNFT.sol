// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";


import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] country = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Antigua", "Virgin Islands","Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia"];
    string[] auxiliaryVerb = ["CanBe", "CouldBe", "Is", "Have", "MayBe", "MightBe", "MustBe", "Shall", "ShouldBe", "WillBe", "WouldBe"];
    string[] negativeNoun = [ "Abrasive", "Apathetic", "Controlling", "Dishonest", "Impatient", "Anxious", "Betrayed", "Disappointed", "Embarrassed", "Jealous", "Abysmal", "Bad", "Callous", "Corrosive", "Damage", "Despicable", "Enraged", "Fail", "Gawky", "Haggard", "Hurt", "Icky", "Insane", "Jealous", "Lose", "Malicious", "Naive" ];

    constructor() ERC721("UnicornNFT", "UNICORN") {
        console.log("This is my NFT contract. Whoa!");
    }

    function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
    }

    function pickRandom(uint256 tokenId, string[] memory wordList) internal pure returns (string memory) {
      uint256 rand = random(string(abi.encodePacked(wordList[1], Strings.toString(tokenId))));
      rand = rand % wordList.length;
      return wordList[rand];
    }

    function makeAnEpicNFT() public {
      // Get the current tokenId, this starts at 0.
      uint256 newItemId = _tokenIds.current();

      string memory combinedWord = string(abi.encodePacked(pickRandom(newItemId, country), pickRandom(newItemId, auxiliaryVerb), pickRandom(newItemId, negativeNoun)));
      string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));
      
      string memory json = Base64.encode(bytes(
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
      ));

      string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
      );

      // Actually mint the NFT to the sender using msg.sender.
      _safeMint(msg.sender, newItemId);

      // Set the NFTs data.
      _setTokenURI(newItemId, finalTokenUri);

      console.log("An NFT with ID %s has been minted to %s", newItemId, msg.sender);

      // Increment the counter for when the next NFT is minted.
      _tokenIds.increment();
    }
}