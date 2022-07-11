const {ethers} = require('hardhat')
const {expect, use} = require('chai')

// tHe main goal will be that a third party will pay for the token transfer 
// write a token smart contract and mint 10000 token to user
// user will approve recipient for certain number of transactions
// relayer will pay for the transaction
describe("Testing Meta Transactions",() =>{


    let token,tokenSender
    let user // sign the transaction
    let relayer //pay for the transaction
    let  recipient1,recipient2,recipient3 // recive the transaction
    before('Deployment',async() =>{
         const Token = await ethers.getContractFactory('MyToken')
         const contractToken = await ethers.getContractFactory('TokenSender')
         token = await Token.deploy()
         tokenSender = await contractToken.deploy()
         await token.deployed();
         await tokenSender.deployed();

         [user,relayer,recipient1,recipient2,recipient3] = await ethers.getSigners()
    })


    it('Single transaction [relayer sends single transaction at a time]',async() =>{

        // can I do this on front end with only user address [might not]
        const userTokeninstance = await token.connect(user)
        let bal = await userTokeninstance.balanceOf(user.address)


        console.log(ethers.BigNumber.from(bal))    

        // minting tokens for user
        const mintTxn = await userTokeninstance.mint(ethers.utils.parseEther('10000'))
        let amount = ethers.utils.parseEther('100');
        // approving 100 token to transfer to recipient1

        const approvetxn =  await userTokeninstance.approve(tokenSender.address,ethers.BigNumber.from(
            "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
        ))


        await tokenSender.transfer(user.address,recipient1.address,amount,token.address)

        let bal1 = await token.balanceOf(recipient1.address)

        // check balanaceOf recipent is equal to the transaffered amount
        console.log("new balance is : ",bal1)
        expect(bal1).to.equal(amount)
    })

    


})