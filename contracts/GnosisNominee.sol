//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

//import "hardhat/console.sol";
import "@gnosis.pm/zodiac/contracts/core/Module.sol";

contract GnosisNominee is Module {

    event NomineeModuleSetup(address indexed initiator, address indexed avatar);


    /// @param _owner Address of the owner
    /// @param _avatar Address of the avatar (e.g. a Safe)
    /// @param _target Address that this module will pass transactions to
    /// @param _nominee Address of the nominee

    constructor(
        address _owner,
        address _avatar,
        address _target,
        address _nominee
    ) {
        bytes memory initParams = abi.encode(
            _owner,
            _avatar,
            _target,
            _nominee
        );
        setUp(initParams);
    }

    function setUp(bytes memory initParams) public override {
        (
            address _owner,
            address _avatar,
            address _target,
            address _nominee
        ) = abi.decode(
            initParams,
            (address, address, address, address)
        );
        __Ownable_init();
        require(_avatar != address(0), "Avatar can not be zero address");
        avatar = _avatar;
        require(_target != address(0), "Target can not be zero address");
        target = _target;

        transferOwnership(_owner);

        emit NomineeModuleSetup(msg.sender, _avatar);
    }

}
