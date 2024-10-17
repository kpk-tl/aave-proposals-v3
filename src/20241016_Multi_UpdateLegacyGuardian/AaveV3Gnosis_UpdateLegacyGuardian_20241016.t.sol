// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis_UpdateLegacyGuardian_20241016} from './AaveV3Gnosis_UpdateLegacyGuardian_20241016.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {RenewalV3BaseTest, GuardianUpdateTestParams} from './RenewalV3BaseTest.sol';
/**
 * @dev Test for AaveV3Gnosis_UpdateLegacyGuardian_20241016
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20241016_Multi_UpdateLegacyGuardian/AaveV3Gnosis_UpdateLegacyGuardian_20241016.t.sol -vv
 */
contract AaveV3Gnosis_UpdateLegacyGuardian_20241016_Test is RenewalV3BaseTest {
  AaveV3Gnosis_UpdateLegacyGuardian_20241016 internal proposal;
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 36532610);
    proposal = new AaveV3Gnosis_UpdateLegacyGuardian_20241016();
  }
  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_UpdateLegacyGuardian_20241016', AaveV3Gnosis.POOL, address(proposal));
  }
  /**
   * @dev executes the test to check the guardian is updated correctly
   */
  function test_guardianUpdate() public {
    _checkGuardianUpdate(
      GuardianUpdateTestParams({
        proposal: address(proposal),
        oldGuardian: MiscGnosis.PROTOCOL_GUARDIAN,
        protocolGuardian: proposal.PROTOCOL_GUARDIAN(),
        governanceGuardian: proposal.GOVERNANCE_GUARDIAN(),
        aclManager: AaveV3Gnosis.ACL_MANAGER,
        poolConfigurator: AaveV3Gnosis.POOL_CONFIGURATOR,
        governance: address(0),
        payloadsController: address(GovernanceV3Gnosis.PAYLOADS_CONTROLLER)
      })
    );
  }
}