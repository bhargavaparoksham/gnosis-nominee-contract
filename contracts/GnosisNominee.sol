//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

//import "hardhat/console.sol";
import "./IGnosisSafe.sol";
import "@gnosis.pm/zodiac/contracts/core/Module.sol";

contract GnosisNominee is Module {

    // Owner -> Nominee
    mapping (address => address) public nominee;
    // Owner -> takeOverTime i.e time after which the nominee can takeover the Owner's safe, if the owner goes inactive.
    mapping (address => uint256) public takeOverTime;
    // Owner -> Last Active timestamp
    mapping (address => uint256) public lastActiveTimestamp;

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

        // Nominee Modue setup event
        emit NomineeModuleSetup(msg.sender, _avatar);
    }


    // Each owner of the gnosis safe can set their nominee & takeOverTime

    function setNominee(address _nominee, uint256 _takeOverTime) public {
        // Only one of the safe owners can set a nominee
        require(IGnosisSafe(avatar).isOwner(msg.sender),"You need be an owner of the safe");
        takeOverTime[msg.sender] = _takeOverTime;        
        nominee[msg.sender] = _nominee;
        lastActiveTimestamp[msg.sender] = block.timestamp;
        //takeOverTime[msg.sender] = _takeOverTime;
    }


    // The nominee's of the gnosis safe can transfer ownership using below function

    function transferSafeOwnership(address _currentOwner, address _prevOwner) public {

        // Only a nominee of one of the safe owner's can call this function
        require(nominee[_currentOwner] == msg.sender, "You are not the nominee for this account");
        uint256 _currentOwnerActiveTill = lastActiveTimestamp[_currentOwner] + takeOverTime[_currentOwner];
        // Ownership can be transferred only after take over time is passed since the last time owner was active.
        require(_currentOwnerActiveTill < block.timestamp, "Ownership transfer can be done only after current time is greater than currentOwnerActiveTill");
        // swapOwner(address prevOwner, address oldOwner, address newOwner)
        bytes memory data = abi.encodeWithSignature("swapOwner(address,address,address)", _prevOwner, _currentOwner, nominee[_currentOwner]);
        require(
            exec(avatar, 0, data, Enum.Operation.Call),
            "Error in swapping owner"
        );
    }


    // Function gives currentOwnerActiveTill time

    function currentOwnerActiveTill(address _currentOwner) public view returns(uint256 _currentOwnerActiveTill) {
        require(takeOverTime[_currentOwner] > 0, "Current Owner has not set a nominee & takeOverTime yet");
        require(IGnosisSafe(avatar).isOwner(_currentOwner),"The address in not an owner of the safe");
        _currentOwnerActiveTill = lastActiveTimestamp[_currentOwner] + takeOverTime[_currentOwner];
    }


    // Funtion that current owner needs to use to update that he is active / alive.

    function updateOwnerStatus() public {
        require(IGnosisSafe(avatar).isOwner(msg.sender),"You need be an owner of the safe");
        lastActiveTimestamp[msg.sender] = block.timestamp;

    }

}
