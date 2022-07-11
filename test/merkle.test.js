// const { expect, assert } = require("chai");
// const { ethers } = require("hardhat");
// const keccak256 = require("keccak256");
// const { MerkleTree } = require("merkletreejs");


// function encodeLeaf(address, spots){

//     return ethers.utils.defaultAbiCoder.encode(
//         ["address", "uint64"],
//         [address, spots]    
//     )
// }


// describe('cheking tree working',() =>{

//     let moonpotion,deployer,addr1,addr2,merkleTree
//     let list = []
//     it('Checking initial root',async () =>{

//         const MoonPotion = await ethers.getContractFactory("MoonPotion");
//         moonpotion = await MoonPotion.deploy();
//         await moonpotion.deployed();
//         [deployer,addr1,addr2] = await ethers.getSigners()

//         expect(await moonpotion._root()).to.equal(ethers.constants.HashZero)

//     })

//     it('putting new address in tree',async() =>{

//         list = ["ajay"]
//         let index = list.length-1;
        
//         merkleTree = new MerkleTree(list,keccak256,{
//             hashLeaves : true,
//             sortPairs : true
//         })


//         let proof = merkleTree.getHexProof(keccak256(list[index]))

//         let v = await moonpotion.verify(proof,keccak256(list[index]))

//         expect(v).to.equal(false)

//         await moonpotion.setName(
//             list[0], // name as string 
//             keccak256(list[index]), // keccak265 hash of the name (string)
//             merkleTree.getHexProof(keccak256(list[index])), // get merkleproof with the newly entered element
//             merkleTree.getHexRoot() //merkle root of the new tree 
//             )

//         // root should be equal to new root
//         expect(await moonpotion._root()).to.equal(merkleTree.getHexRoot())
        
//         v = await moonpotion.verify(
//         merkleTree.getHexProof(keccak256(list[index])),
//         keccak256(list[index])
//         )

//         expect(v).to.equal(true)

//         list.push("aman")
        
//         merkleTree = new MerkleTree(list,keccak256,{
//             hashLeaves : true,
//             sortPairs : true
//         })

//         v = await moonpotion.verify(
//             merkleTree.getHexProof(keccak256(list[index])),
//             keccak256(list[index])
//             )
    
//         expect(v).to.equal(false)

//     })


//     it('Trying to choose already existing name',async() =>{

//         list.push("ajay")

//         let index = list.length - 1;

//         merkleTree = new MerkleTree(list,keccak256,{
//             hashLeaves : true,
//             sortLeaves : true
//         })

//         await moonpotion.setName(
//             list[index],
//             keccak256(list[index]),
//             merkleTree.getHexProof(list[index]),
//             merkleTree.getHexRoot()
//         )
        
//     })
    
//     // verify the name is in the list 
//     // verify one random other name is not in the list
//     // updated root

// })


// // Fetch names from the database
// // fetch it and put them on a list
// // build a merkle tree using it
// // fetch the roothash from contract
// // 