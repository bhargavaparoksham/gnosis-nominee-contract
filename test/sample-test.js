const { expect } = require("chai");
const { ethers } = require("hardhat");

// describe("Greeter", function () {
//   it("Should return the new greeting once it's changed", async function () {
//     const Greeter = await ethers.getContractFactory("Greeter");
//     const greeter = await Greeter.deploy("Hello, world!");
//     await greeter.deployed();

//     expect(await greeter.greet()).to.equal("Hello, world!");

//     const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

//     // wait until the transaction is mined
//     await setGreetingTx.wait();

//     expect(await greeter.greet()).to.equal("Hola, mundo!");
//   });
// });



// Sample test function that can be used in main contract


    // // Change Threshold 

    // function changeThresholdA(uint256 _threshold) public {

    //     require(IGnosisSafe(avatar).isOwner(msg.sender),"You need be an owner of the safe");
    //     // changeThreshold(uint256 _threshold)
    //     bytes memory data = abi.encodeWithSignature("changeThreshold(uint256)", _threshold);
    //     require(
    //         exec(avatar, 0, data, Enum.Operation.Call),
    //         "Error in changing _threshold"
    //     );
    // }



    // // Transfer Chainlink test function

    // function transferTransfer(uint256 _amount, address _token) public {

    //     require(IGnosisSafe(avatar).isOwner(msg.sender),"You need be an owner of the safe");
    //     // transfer(address,uint256)
    //     bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", msg.sender, _amount);
    //     require(
    //         exec(_token, 0, data, Enum.Operation.Call),
    //         "Error in token transfer"
    //     );
    // }