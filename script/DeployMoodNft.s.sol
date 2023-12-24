// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft nft) {
        string memory happySvg = vm.readFile("./img/mood-happy.svg");
        string memory sadSvg = vm.readFile("./img/mood-sad.svg");
        // console.log(happySvg, sadSvg);
        vm.startBroadcast();
        nft = new MoodNft(svgToImageURI(happySvg), svgToImageURI(sadSvg));
        vm.stopBroadcast();
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(abi.encodePacked(svg))
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}
