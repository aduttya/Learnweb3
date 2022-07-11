// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

interface Token {
    function totalSupply() external view returns(uint);
    function name() external view returns(string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns(uint8);
    function balanceOf(address _addr) external view returns(uint);
    function transfer(address _to , uint _value) external returns(bool success);
    function transferFrom(address _from, address _to , uint _value) external returns (bool success);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint);
}
contract Sale{

    address public owner;
    uint public feePerHour;
    bool isStart;
    address tokenAddress;
    uint tokenFee;
    event Rented(address indexed _to, uint _init, uint _end);
    event Sold(address indexed _to, uint _amount);
    // event BidPlaced (address indexed _to,uint _amount);
    

    struct Renter {
       address renterAddress;
       uint initPeriod;
       uint endPeriod;
    }


    Renter public currentRenter;

    constructor(){
       owner = msg.sender;   
    }

    function startSale() external{
        require(currentRenter.renterAddress != address(0),"contract hasn't been rented yet");
        require(msg.sender == currentRenter.renterAddress,"only renter can start the sale");
        isStart = true;
    }

    function endSale() external{
        require(currentRenter.renterAddress != address(0),"contract hasn't been rented yet");
        require(msg.sender == currentRenter.renterAddress,"only renter can end the sale");
        isStart = false;
    }

    function setRentFee(uint _val)external {
        require(msg.sender == owner, "only owner can set the fee");
        feePerHour = _val;
    }

    function setTokenAddress (address _addr) external{
        require(currentRenter.renterAddress != address(0),"contract hasn't been rented yet");
        require(msg.sender == currentRenter.renterAddress,"only renter can set the address");
        tokenAddress = _addr;
    }

    function setFee(uint _tokenFee) public {
        require(currentRenter.renterAddress != address(0),"contract hasn't been rented yet");
        require(msg.sender == currentRenter.renterAddress,"only renter can set the fee");
        tokenFee = _tokenFee;
    }

    function buy(uint _amount) external payable{
        require(tokenAddress != address(0),"token address has not been set yet");
        require(msg.value >= _amount*tokenFee,"amount is not enough");
        require(Token(tokenAddress).balanceOf(address(this)) > _amount, "not enough allownce");
        Token(tokenAddress).transfer(msg.sender,_amount);
        emit Sold(msg.sender, _amount);
    }

    // rent the contract
   function rent(uint _val) external payable{
    //    val is amount of time in seconds 
        require(currentRenter.renterAddress == address(0),"already on rent");
        require(feePerHour != 0,"fee can't be zero");
        require(msg.value >= ((_val/3600)*feePerHour),"not appropriate fee");
        payable(owner).transfer(msg.value);
       currentRenter.renterAddress = msg.sender;
       currentRenter.initPeriod = block.timestamp;
       currentRenter.endPeriod = block.timestamp + _val;
       emit Rented(msg.sender,currentRenter.initPeriod,currentRenter.endPeriod);
   }
    function incrementRentPeriod(uint _val) external payable{
    //    val is amount of time in seconds 
        require(msg.sender == currentRenter.renterAddress,"only current renter can increase the rental period");
        require(feePerHour != 0,"fee can't be zero");
        require(msg.value >= ((_val/3600)*feePerHour),"not appropriate fee");
        payable(owner).transfer(msg.value);
        currentRenter.endPeriod = block.timestamp + _val;
        emit Rented(msg.sender,currentRenter.initPeriod,currentRenter.endPeriod);
   }

   function exit() external {
       require(currentRenter.renterAddress == msg.sender , "not the current renter");
       payable(currentRenter.renterAddress).transfer(address(this).balance);
       delete currentRenter;
   }
   
   function balance() public view returns(uint){
       return owner.balance;
   }
    // struct Bids {
    //     address bider;
    //     uint amount;
    // }

    // Bids [] public bids;

       // place bid if auction is running
    // function bid() external payable{
    //     require(currentRenter.renterAddress != address(0),"contract hasn't been rented yet");
    //     require(msg.value > bids[bids.length -1].amount,"bid amount should be greater than last bid");
    //     bids.push(Bids(msg.sender, msg.value));
    //     emit BidPlaced(msg.sender, msg.value);
    // }


//    if current renter have time out 

    // AggregatorV3Interface internal pricefeed;

    // constructor() {
        
    //     pricefeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    // }

    // function get() public view returns(int){
    //     ( ,int price,,,) = pricefeed.latestRoundData();
    //     return price;
    // }
}