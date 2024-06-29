// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

struct AirDrop {
    uint256 id; 
    string name; 
    address erc20; 
    uint256 totalDropAmount; 
    uint256 [] tokenAmounts; 
    address allocationContract; 
    address [] recipients; 
}

interface IMetDDrop {

    function isClaimed(uint256 _dropid) view external returns (bool _claimed);

    function claim( uint256 _dropId) external returns (uint256 _amount);

    function getAvailableDropsIds() view external returns (uint256 [] memory _dropIds);

    function getDrop(uint256 _dropId) view external returns (AirDrop memory _drop);

    function isEligibile(uint256 _dropId) view external returns (bool _isEligible);

    function runDrop(string memory _dropName, address _erc20, uint256 _totalDropAmount, uint256 [] memory tokenAmounts, address [] memory _recipients) payable external returns (uint256 _dropId);

    function runDrop(string memory _dropName, address _erc20, uint256 _totalDropAmount, address _allocationContract, address [] memory _recipients) payable external returns (uint256 _dropId);

}