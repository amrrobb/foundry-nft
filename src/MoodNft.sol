// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    // errors
    error MoodNft__CantFlipMoodIfNotOwner();
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    event CreatedNFT(uint256 indexed tokenCounter);

    constructor(
        string memory _happySvgImageUri,
        string memory _sadSvgImageUri
    ) ERC721("MoodNFT", "Moody") {
        s_tokenCounter = 0;
        s_happySvgImageUri = _happySvgImageUri;
        s_sadSvgImageUri = _sadSvgImageUri;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNFT() public {
        // how would you require payment for this NFT?
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
        emit CreatedNFT(s_tokenCounter);
    }

    function flipMood(uint256 tokenId) public {
        if (_ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI = s_tokenIdToMood[tokenId] == Mood.HAPPY
            ? s_happySvgImageUri
            : s_sadSvgImageUri;

        bytes memory tokenBytes = bytes(
            abi.encodePacked(
                '{"name": "',
                name(),
                '", "description": "an NFT that represents owner mood',
                '", "attributes": [{"trait_type": "moodiness", "value": 100}]',
                '", "image": "',
                imageURI,
                '"}'
            )
        );

        return string(abi.encodePacked(_baseURI(), Base64.encode(tokenBytes)));
    }

    // function getMood(uint256 tokenId) public view returns (Mood) {
    //     return s_tokenIdToMood[tokenId];
    // }
}
