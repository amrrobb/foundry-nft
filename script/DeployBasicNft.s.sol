// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    function run() public returns (BasicNft nft) {
        vm.startBroadcast();
        nft = new BasicNft();
        vm.stopBroadcast();
    }
}
