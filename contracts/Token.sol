// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract MyToken is ERC20,Ownable {
    constructor() ERC20("MyToken", "MTK") {}

    function mint(uint _amount) public onlyOwner{
        _mint(msg.sender,_amount);
    }
}

contract TokenSender{

    using ECDSA for bytes32;


    function transfer(address sender, address recipient, uint amount, address contractToken) public{
        bool sent = ERC20(contractToken).transferFrom(sender, recipient, amount);
        require(sent, "Transfer failed");
    }
    function getHash(address sender, address recipient,uint amount, address contractToken)public pure returns(bytes32){

            return keccak256(abi.encodePacked(sender,recipient,amount,contractToken));   
    }
}