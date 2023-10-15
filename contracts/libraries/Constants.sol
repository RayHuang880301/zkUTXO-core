// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library Constants {
    /// @notice The address to represent native token on deployed network (i.e. ETH on Ethereum)
    address internal constant DEFAULT_NATIVE_TOKEN_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    /// @notice The native token on deployed network
    IERC20 internal constant DEFAULT_NATIVE_TOKEN = IERC20(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE);

    /// @notice The default tree depth for each token tree
    uint256 internal constant DEFAULT_TREE_DEPTH = 24;

    /// @notice The default leaf zero value = uint256(keccak256(abi.encode("cipher"))) % SNARK_SCALAR_FIELD
    uint256 internal constant DEFAULT_LEAF_ZERO_VALUE =
        14693734620209785393966954230592927715867821236176778989295931055453090412689;

    /// @notice The max depth of merkle tree
    uint256 internal constant MAX_DEPTH = 32;

    /// @notice The snark scalar field
    uint256 internal constant SNARK_SCALAR_FIELD =
        21888242871839275222246405745257275088548364400416034343698204186575808495617;

    /// @notice The fee base for calculating fee amount
    uint16 internal constant FEE_BASE = 10000;

    /// @notice The size of valid history roots
    uint8 internal constant VALID_HISTORY_ROOTS_SIZE = 32;

    /// @notice The number of one bytes in decimal
    uint256 internal constant NUM_OF_ONE_BYTES = 256;

    /// @notice The default zero value for each node in the merkle tree
    ///      Z_0 = DEFAULT_LEAF_ZERO_VALUE
    ///      Z_1 = poseidon(Z_0, Z_0) % SNARK_SCALAR_FIELD
    ///      Z_2 = poseidon(Z_1, Z_1) % SNARK_SCALAR_FIELD
    ///      ...
    ///      Z_24 = poseidon(Z_23, Z_23) % SNARK_SCALAR_FIELD
    uint256 internal constant Z_0 = DEFAULT_LEAF_ZERO_VALUE;
    uint256 internal constant Z_1 = 17332802755933328192408765056487990934239404033451666296890662382731248045851;
    uint256 internal constant Z_2 = 13816207349929625647700150838880158024387312517940091995572778217823342715863;
    uint256 internal constant Z_3 = 15880023301658773447526522844980466981236095317046464125867625207058086698736;
    uint256 internal constant Z_4 = 11896318397199403626188107684511986262044680443042053627885775547359091366261;
    uint256 internal constant Z_5 = 1452329808241783992599386621604836196947391559322183291268387159695282746014;
    uint256 internal constant Z_6 = 10787070409075596637542860533947650577469763125244318332126051777587262481331;
    uint256 internal constant Z_7 = 12851923907862160511654406211589081098189165086072774604130836753592887283658;
    uint256 internal constant Z_8 = 5933749590513544834352817823383750912364392852032745654264076073355044096539;
    uint256 internal constant Z_9 = 19894247144313135802558495215239734008629946727045762274341614388339958773343;
    uint256 internal constant Z_10 = 3959966760160459360556352491953183311474986891033778692958428620086103653394;
    uint256 internal constant Z_11 = 16733173979381463823614790346580946693812728645195554446123194226819209230030;
    uint256 internal constant Z_12 = 12142059936001576506455008400214201903892965545817082836558309929414608006515;
    uint256 internal constant Z_13 = 8393750022197633890672278504555377757488580144728201610163310230105558190185;
    uint256 internal constant Z_14 = 19816759793882160345832596599651956111531124337769955342013338819606963268700;
    uint256 internal constant Z_15 = 7072093117152274908980085353699696340062725400353194536687647551878741919997;
    uint256 internal constant Z_16 = 2033484237315207569793497417192465934336044809229430561758928010543469419166;
    uint256 internal constant Z_17 = 11115131038840302546659751745320309860883783324161458267805011398942655446026;
    uint256 internal constant Z_18 = 4207338730011196969892177712432032571205550691142239375749126462030460264828;
    uint256 internal constant Z_19 = 11729733096746073613332327461772640177382946471445573944442248811346480477046;
    uint256 internal constant Z_20 = 6233405750040527663753735995809396560139036763977601428049400086008206185390;
    uint256 internal constant Z_21 = 4889713235613843821328213519577028064891109957049913632935532279070509959371;
    uint256 internal constant Z_22 = 10647202757241815535311325486097181665484941684909665118566062921680366510875;
    uint256 internal constant Z_23 = 21240587291817950574157036658492781121792295008187809071031588176936501471747;
    uint256 internal constant Z_24 = 10950512088864623017193855008549027964818627314169113560361044208148762403141;
}
