pragma solidity ^0.4.10;

contract Factory {

    address[] public allContracts;
    uint256 public contractCount;
    address public factoryOwner;

    function Factory() public {
        factoryOwner = msg.sender;
        contractCount = 0;
    }

    function createContract( uint256 _principal, uint256 _collAmount, uint256 _duration,uint256 _loanExpWeeks) public {
        address newContract = new ethindia(_principal,_collAmount,_duration,_loanExpWeeks);
        allContracts.push(newContract);
        contractCount++;
    }

    function getAllContracts() public view returns (address[]) {
        return allContracts;
    }

    function getByID(uint256 queryID) public view returns (address) {
        return allContracts[queryID];
    }
}

contract ethindia {
    address[] lenders;
    address[] lenders2;
    uint[] lendinghistory;
    uint[] lendinghistory2;
    address borrower;
    address winbidder;

    uint256 principal = 0;
    uint256 collAmount = 0;
    uint256 duration = 0;
    uint256 rate = 0;
    uint256 loanExpWeeks = 0;

    uint256 interest = 0;

    uint256 public loanFill = 0;
    bool loanFilledStatus = false;

    uint256 loanRepay = 0;
    bool loanRepayStatus = false;

    uint256 lenderCount = 0;

    mapping (int => address) lender;
    mapping (address => uint) lendertoamount;

    function ethindia( uint256 _principal, uint256 _collAmount, uint256 _duration, uint256 _loanExpWeeks) public {
        borrower = msg.sender;
        principal = _principal;
        collAmount = _collAmount;
        duration = _duration;
        loanExpWeeks = _loanExpWeeks;

    }

    function displayInfo() constant returns(address,uint256,uint256,uint256,uint256,uint256,uint256) {
      return (address(this),principal,collAmount,duration,rate,loanExpWeeks,loanFill);
    }

    function showlendinghistory() constant returns(uint[]) {
      return lendinghistory;
    }

    function selectwinner(uint index) constant returns(address) {
      return lenders[index];
    }

    function payfromwinner(uint index) {
      lenders2.push(lenders[index]);
      lendinghistory2.push((principal*30)/100);
      loanFill+=(principal*30)/100;
    }

    function getBorrower() constant returns(address){
      return borrower;
    }

    function submitBid(uint value) public  {
      lenders.push(msg.sender);
      lendinghistory.push(value);
    }
    function payToLoan(uint payAmount) public {
        require(!loanFilledStatus);
        
        lenders2.push(msg.sender);
        lendinghistory2.push(payAmount);

        loanFill += payAmount;

        lendertoamount[msg.sender] += payAmount;

        if(loanFill == principal) {
            loanFilledStatus = true;
            interest = (principal * duration * rate) / 100;
        }
    }

    function payBackLoan(uint repayAmount) public {
        require(msg.sender == borrower && !loanRepayStatus);

        loanRepay += repayAmount;
        if(loanRepay == (principal + interest)) {
            loanRepayStatus = true;
        }
    }
}
