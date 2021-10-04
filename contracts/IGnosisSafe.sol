//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

// Gnosis Safe custom interface

interface IGnosisSafe {

	// Swap Owner

	function swapOwner(address prevOwner, address oldOwner, address newOwner) external;

	// Is Owner of the safe

	function isOwner(address owner) external view returns (bool);

	// Get all owner addresses

	function getOwners() external view returns (address[] memory);

	// Get Threshold

    function getThreshold() external view returns (uint256);


}