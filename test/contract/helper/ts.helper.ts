import { expect } from "chai";
import { utils } from "ethers";
import { Cipher } from "@typechain-types";
import { PublicInfoStruct } from "../../../typechain-types/contracts/Cipher";
import { generateCipherTx } from "@scripts/gen_testcase";
import { IncrementalQuinTree } from "@scripts/lib/IncrementalQuinTree";
import { getUtxoType } from "@scripts/lib/utxo.helper";
import { CipherPayableCoin } from "@scripts/lib/utxo/coin";
import hre from "hardhat";
const ethers = hre.ethers;

export interface CreateTxTestCase {
  tokenAddress: string;
  txs: Array<Transaction>;
}

export interface Transaction {
  name: string;
  feeRate?: string;
  relayer?: string;
  recipient?: string;

  publicIn: string;
  publicOut: string;
  privateIns: string[];
  privateOuts: string[];
}

export function generateTest(testCase: CreateTxTestCase, context: {
  tree: IncrementalQuinTree,
  cipher: Cipher
}) {
  return async () => {
    const { txs, tokenAddress } = testCase;
    const { tree, cipher } = context;
    let previousOutCoins: CipherPayableCoin[] = [];
    
    for (let i = 0; i < txs.length; i++) {
      const tx = txs[i];
      const privateInputLength = txs[i].privateIns.length;
      const privateOutputLength = txs[i].privateOuts.length;
      const publicInfo: PublicInfoStruct = {
        utxoType: getUtxoType(privateInputLength, privateOutputLength),
        feeRate: tx.feeRate || "0",
        relayer: tx.relayer || "0x0000000000000000000000000000000000000000", // no fee
        recipient: tx.recipient || "0xffffffffffffffffffffffffffffffffffffffff", // TODO: get from user address
        encodedData: utils.defaultAbiCoder.encode(["address"], [tokenAddress]),
      };
      const {
        privateOutCoins,
        contractCalldata,
      } = await generateCipherTx(
        tree,
        {
          publicInAmt: utils.parseEther(tx.publicIn).toBigInt(),
          publicOutAmt: utils.parseEther(tx.publicOut).toBigInt(),
          privateInCoins: previousOutCoins,
          privateOutAmts: tx.privateOuts.map((v) => utils.parseEther(v).toBigInt()),
        },
        publicInfo,
      );
      previousOutCoins = privateOutCoins;

      const circuitName = `n${privateInputLength}m${privateOutputLength}`;
      expect(circuitName).to.equal(txs[i].name);
      const testName = `createTx with n${privateInputLength}m${privateOutputLength}`;
      console.log(testName);

      const beforeEthBalance = await ethers.provider.getBalance(
        cipher.address
      );
      console.log(
        `${testName}: txIndex=${i}, beforeEthBalance`,
        beforeEthBalance.toString()
      );
      const result = await cipher.createTx(
        contractCalldata.utxoData,
        contractCalldata.publicInfo,
        { value: utils.parseEther(tx.publicIn) }
      );
      await result.wait();
      // TODO: check event log
      const afterEthBalance = await ethers.provider.getBalance(
        cipher.address
      );
      console.log(
        `${testName}: txIndex=${i}, afterEthBalance`,
        afterEthBalance.toString()
      );
    }
  }
}
