// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DeploymentBase} from "../Deploy.s.sol";

contract GoerliDeployment is DeploymentBase {
    uint256 scroll;

    function _initFork() internal override {
        scroll = vm.createFork("scroll");
    }

    function _selectFork() internal override {
        vm.selectFork(scroll);
    }
}
