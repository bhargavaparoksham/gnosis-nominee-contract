//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

//import "hardhat/console.sol";
import "./IGnosisSafe.sol";
import "@gnosis.pm/zodiac/contracts/core/Module.sol";

contract GnosisNominee is Module {

    // Owner -> Nominee
    mapping (address => address) public nominee;
    // Owner -> takeOverTime
    mapping (address => uint256) public takeOverTime;

    event NomineeModuleSetup(address indexed initiator, address indexed avatar);


    // @param _owner Address of the owner
    // @param _avatar Address of the avatar (e.g. a Gnosis Safe)
    // @param _target Address of the contract that will call exec function

    constructor(
        address _owner,
        address _avatar,
        address _target
    ) {
        bytes memory initParams = abi.encode(
            _owner,
            _avatar,
            _target
        );
        setUp(initParams);
    }

    function setUp(bytes memory initParams) public override {
        (
            address _owner,
            address _avatar,
            address _target
        ) = abi.decode(
            initParams,
            (address, address, address)
        );
        __Ownable_init();
        require(_avatar != address(0), "Avatar can not be zero address");
        avatar = _avatar;
        require(_target != address(0), "Target can not be zero address");
        target = _target;
        
        transferOwnership(_owner);

        emit NomineeModuleSetup(msg.sender, _avatar);
    }


    // Each owner of the gnosis safe can set their nominee

    function setNominee(address _nominee) public {
        require(IGnosisSafe(avatar).isOwner(msg.sender),"You need be an owner of the safe");
        nominee[msg.sender] = _nominee;
        //takeOverTime[msg.sender] = _takeOverTime;
    }


    // The nominee of the gnosis safe can transfer ownership using below function

    function transferSafeOwnership(address _oldOwner) public {

        require(nominee[_oldOwner] == msg.sender, "You are not the nominee for this account");
        // swapOwner(address prevOwner, address oldOwner, address newOwner)
        bytes memory data = abi.encodeWithSignature("swapOwner(address,address,address)", _oldOwner, _oldOwner, nominee[_oldOwner]);
        require(
            exec(avatar, 0, data, Enum.Operation.Call),
            "Error in swapping owner"
        );
    }

}
