// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// testing framework
import "forge-std/Test.sol";

// source & mock
import {CipherVerifier} from "../contracts/CipherVerifier.sol";
import {CipherMock} from "./mock/CipherMock.sol";
import {ERC20Mock} from "./mock/ERC20Mock.sol";
import {TokenLibMock} from "./mock/TokenLibMock.sol";


// interfaces
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IPoseidonT3} from "../contracts/interfaces/IPoseidonT3.sol";

// library
import {TreeData} from "../contracts/DataType.sol";
import {TokenLib} from "../contracts/libraries/TokenLib.sol";
import {TreeLib} from "../contracts/libraries/TreeLib.sol";
import {Helper} from "../contracts/libraries/Helper.sol";

// events, errors and constants
import {Constants} from "../contracts/libraries/Constants.sol";
import {Errors} from "../contracts/libraries/Errors.sol";
import {Events} from "../contracts/libraries/Events.sol";
import {Proof, PublicInfo, PublicSignals} from "../contracts/DataType.sol";

abstract contract BaseTest is Test {
    using stdJson for string;

    address internal poseidonT3;

    address internal merkleTree;

    CipherVerifier internal verifier;

    CipherMock internal main;

    ERC20Mock internal erc20;

    TokenLibMock internal tokenLibMock;

    address internal userBob;

    address internal userAlice;


    function setUp() public virtual {
        string memory root = vm.projectRoot();
        string memory path = string.concat(root, "/tests/utils/PoseidonT3.json");
        string memory json = vm.readFile(path);

        // deploy poseidonT3 library
        address addr;
        bytes memory creation = json.readBytes(".creationCode");
        assembly {
            addr := create(0, add(0x20, creation), mload(creation))
        }
        poseidonT3 = addr;

        // deploy verifier
        verifier = new CipherVerifier();

        // deploy cipher
        main = new CipherMock(address(verifier), address(poseidonT3));

        // deploy erc20
        erc20 = new ERC20Mock("Test", "T", 18);

        // deploy tokenLib
        tokenLibMock = new TokenLibMock();

        // address(this)
        vm.deal(address(this), 100 ether);
        erc20.mint(address(this), 100 ether);

        // user bob
        userBob = makeAddr("BOB");
        userAlice = makeAddr("ALICE");
    }
}
