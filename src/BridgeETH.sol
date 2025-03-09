// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";


contract BridgeETH is Ownable{
    uint256 public balance;
    address public tokenAddress;

    event Deposit(address indexed depositor, uint amount);
    mapping(address => uint256) public pendingBalance;


    //msg.sender = the person deoploying the contract
    //contract expects the address of the token to be bridged
    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    /*when the user visits the site-
    step 1. They need to approve the contract to spend at least an amount of money
    step 2. They can then deposit the token i.e allow the contract to take the token to itself */


    //deposit transfers token from user to the contract (transferFrom())
    function deposit(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress, "Invalid token address");
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount, "insufficient allowance");
        require(_tokenAddress.transferFrom(msg.sender, address(this), _amount));

        emit Deposit(msg.sender, _amount);

        // pendingBalance[msg.sender] += _amount;

    }


    //withdraw transfers the token from the contract to the user (transfer)
    function withdraw(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress, "Invalid token address");
        require(pendingBalance[msg.sender] >= _amount, "Insufficient balance");
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount);
    }

    //tells us that the userAccount has burned _amount worth of bridge coin on the other side
    function burnedOnOppositeChain(address userAccount, uint256 _amount) public onlyOwner {
        pendingBalance[userAccount] += _amount;
    }
}