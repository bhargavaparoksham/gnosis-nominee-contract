//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

interface IGnosisSafe {

	function swapOwner(address prevOwner, address oldOwner, address newOwner) public;

	function isOwner(address owner) public view returns (bool);

	function getOwners() public view returns (address[] memory);

    function getThreshold() public view returns (uint256);


}