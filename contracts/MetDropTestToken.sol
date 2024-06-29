// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MetDropTestToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable, ERC20Permit {

    int256 coolDown = 24*60*60; 
    mapping(address=>uint256) lastMintDateByAddress; 
    uint256 defaultAmount = 1e18 * 2000; 


    constructor(address initialOwner)
        ERC20("MetDropTestToken", "MDTT")
        Ownable(initialOwner)
        ERC20Permit("MetDropTestToken")
    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint() external returns (uint256 _amount) {
        int256 coolDown_ = int256(block.timestamp - lastMintDateByAddress[msg.sender]); 
        require(coolDown_ > coolDown, " still in cool down period " );
        _amount = defaultAmount; 
        _mint(msg.sender, _amount);
        return _amount; 
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}
