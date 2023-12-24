// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant PUG =
        "https://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4.ipfs.dweb.link/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNFT(PUG);
        vm.stopBroadcast();
    }
}
