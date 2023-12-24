// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftInterationTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "https://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4.ipfs.dweb.link/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsIncorrect() public {
        string memory expectedName = "test";
        string memory actualName = basicNft.name();
        assertNotEq(
            keccak256(abi.encodePacked(expectedName)),
            keccak256(abi.encodePacked(actualName))
        );
    }

    function testNameIsCorrect() public {
        string memory expectedName = "DoogieNFT";
        string memory actualName = basicNft.name();
        assertEq(
            keccak256(abi.encodePacked(expectedName)),
            keccak256(abi.encodePacked(actualName))
        );
    }

    // Arrange, ..., Assert
    function testMintNftAndHasBalance() public {
        vm.prank(USER);
        basicNft.mintNFT(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assertEq(
            keccak256(abi.encodePacked(basicNft.tokenURI(0))),
            keccak256(abi.encodePacked(PUG))
        );
    }
}
