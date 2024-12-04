// SPDX-License-Identifier: MIT
// contracts/MusicNFTBeacon.sol
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";

contract MusicNFTBeacon {
    UpgradeableBeacon public beacon;

    constructor(address implementation) {
        beacon = new UpgradeableBeacon(implementation, msg.sender);
    }

    function createProxy() public returns (address) {
        return address(new BeaconProxy(address(beacon), ""));
    }

    function upgrade(address newImplementation) public {
        beacon.upgradeTo(newImplementation);
    }
}
