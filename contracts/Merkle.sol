// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";


contract MoonPotion{

        bytes32 public _root;
        mapping(address => string) private names;

        event NameRegistered(address _to, string _name, uint _time);

        function setName(string memory _name,bytes32 nameH, bytes32 [] calldata _proof,bytes32 newroot) external {
            require(verify(_proof,nameH) == false,"name is already present");
            _name = string(abi.encodePacked(_name,".potion"));
            names[msg.sender] = _name;
            _root = newroot;
            emit NameRegistered(msg.sender,_name,block.timestamp);
        }

        function getName()external view returns(string memory){
            return names[msg.sender];
        }

        function verify(bytes32 [] calldata _proof,bytes32 _name) public view returns(bool){
            return MerkleProof.verify(_proof,_root,_name);
        }
}