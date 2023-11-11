// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DeploymentBase} from "../Deploy.s.sol";

contract MantleDeployment is DeploymentBase {
    uint256 mantle;

    function _initFork() internal override {
        mantle = vm.createFork("mantle");
    }

    function _selectFork() internal override {
        vm.selectFork(mantle);
    }
}
