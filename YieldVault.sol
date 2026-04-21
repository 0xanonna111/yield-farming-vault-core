// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract YieldVault is ERC20, ReentrancyGuard, Ownable {
    IERC20 public immutable asset;
    address public strategy;

    constructor(address _asset, string memory _name, string memory _symbol) 
        ERC20(_name, _symbol) 
        Ownable(msg.sender) 
    {
        asset = IERC20(_asset);
    }

    function setStrategy(address _strategy) external onlyOwner {
        strategy = _strategy;
    }

    function deposit(uint256 _amount) external nonReentrant {
        uint256 totalAsset = totalAssets();
        uint256 totalShares = totalSupply();

        asset.transferFrom(msg.sender, address(this), _amount);
        
        uint256 shares = (totalShares == 0) ? _amount : (_amount * totalShares) / totalAsset;
        _mint(msg.sender, shares);

        // Move funds to strategy
        asset.approve(strategy, _amount);
        // External call to strategy omitted for brevity
    }

    function withdraw(uint256 _shares) external nonReentrant {
        uint256 totalAsset = totalAssets();
        uint256 amount = (_shares * totalAsset) / totalSupply();

        _burn(msg.sender, _shares);
        asset.transfer(msg.sender, amount);
    }

    function totalAssets() public view returns (uint256) {
        return asset.balanceOf(address(this)) + asset.balanceOf(strategy);
    }
}
