pragma solidity ^0.4.10;

contract Factory {

    address[] public allContracts;
    uint256 public contractCount;
    address public factoryOwner;

    function Factory() public {
        factoryOwner = msg.sender;
        contractCount = 0;
    }

    function createContract( uint256 _principal, uint256 _collAmount, uint256 _duration, uint256 _rate, uint256 _loanExpWeeks) public {
        address newContract = new ethindia(_principal,_collAmount,_duration,_rate,_loanExpWeeks);
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
    address borrower;

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

    function ethindia( uint256 _principal, uint256 _collAmount, uint256 _duration, uint256 _rate, uint256 _loanExpWeeks) public {
        borrower = msg.sender;
        principal = _principal;
        collAmount = _collAmount;
        duration = _duration;
        rate = _rate;
        loanExpWeeks = _loanExpWeeks;

    }

    function payToLoan() public payable {
        require(!loanFilledStatus);

        lenders.push(msg.sender);

        loanFill += msg.value;

        lendertoamount[msg.sender]+=msg.value;

        if(loanFill == principal) {
            loanFilledStatus = true;
            interest = (principal * duration * rate) / 100;
        }
    }

    function payBackLoan() public payable {
        require(msg.sender == borrower && !loanRepayStatus);

        loanRepay += msg.value;
        if(loanRepay == (principal + interest)) {
            loanRepayStatus = true;
        }
    }
}
