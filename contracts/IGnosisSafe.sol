//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

// Gnosis Safe custom interface

interface IGnosisSafe {

	function swapOwner(address prevOwner, address oldOwner, address newOwner) external;

	function isOwner(address owner) external view returns (bool);

	function getOwners() external view returns (address[] memory);

    function getThreshold() external view returns (uint256);


}