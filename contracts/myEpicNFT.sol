// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";


import "hardhat/console.sol";

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

      string memory finalSvg = string(abi.encodePacked(baseSvg, pickRandom(newItemId, country), pickRandom(newItemId, auxiliaryVerb), pickRandom(newItemId, negativeNoun), "</text></svg>"));
      console.log("\n--------------------");
      console.log(finalSvg);
      console.log("--------------------\n");

      // Actually mint the NFT to the sender using msg.sender.
      _safeMint(msg.sender, newItemId);

      // Set the NFTs data.
      _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiRXBpY0xvcmRIYW1idXJnZXIiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIHNxdWFyZSBjb2xsZWN0aW9uIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0TkNpQWdJQ0E4YzNSNWJHVStMbUpoYzJVZ2V5Qm1hV3hzT2lCM2FHbDBaVHNnWm05dWRDMW1ZVzFwYkhrNklITmxjbWxtT3lCbWIyNTBMWE5wZW1VNklERTBjSGc3SUgwOEwzTjBlV3hsUGcwS0lDQWdJRHh5WldOMElIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SW1Kc1lXTnJJaUF2UGcwS0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUlhCcFkweHZjbVJJWVcxaWRYSm5aWEk4TDNSbGVIUStEUW84TDNOMlp6ND0iCn0=");

      console.log("An NFT with ID %s has been minted to %s", newItemId, msg.sender);

      // Increment the counter for when the next NFT is minted.
      _tokenIds.increment();
    }
}