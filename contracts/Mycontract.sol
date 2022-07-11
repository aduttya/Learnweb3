// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "hardhat/console.sol";


import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Test{
     
     function testing(address _token) external returns(bool){
        //  call a function of a smart contract using abi encode
         bytes memory data = abi.encodeWithSignature("transferFrom(address,address,uint)","0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",address(this),500);
         (bool success, bytes memory result) = _token.call(data);
         return success;
     }

     function addr() public view returns(address){
         return address(this);
     }
}