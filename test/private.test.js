// const { expect, assert } = require("chai");
// const { ethers } = require("hardhat");


// describe('Access private variables',() =>{

//     let login 
//     it('deploying ',async() =>{

//         let Login = await ethers.getContractFactory('Login')

//         const usernameBytes = ethers.utils.formatBytes32String('Ajayjkjkjjjjjhfdfdvvgyf tdd')
//         const passBytes = ethers.utils.formatBytes32String('SMriti@786')
//         login = await Login.deploy(usernameBytes,passBytes,"who")
//         await login.deployed()
        

//         let slot0 = await ethers.provider.getStorageAt(login.address,0)
//         let slot1 = await ethers.provider.getStorageAt(login.address,1)

//         console.log(ethers.utils.parseBytes32String(slot0))
//         let slot2 = await ethers.provider.getStorageAt(login.address,2)
//         console.log(slot2)
//         console.log(ethers.utils.parseBytes32String(slot2))

//     })

// })