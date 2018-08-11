pragma solidity ^0.4.10;

contract ethindia {
    address[] lenders;
    address borrower;

    uint256 principal = 0;
    uint256 collAmount = 0;
    uint256 duration = 0;
    uint256 rate = 0;
    uint256 loanExpWeeks = 0;

    uint256 interest = 0;

    uint256 loanFill = 0;
    bool loanFilledStatus = false;

    uint256 loanRepay = 0;
    bool loanRepayStatus = false;

    uint256 lenderCount = 0;

    mapping (int => address) lender;

    function createLoan( uint256 _principal, uint256 _collAmount, uint256 _duration, uint256 _rate, uint256 _loanExpWeeks) public {
        borrower = msg.sender;
        principal = _principal;
        collAmount = _collAmount;
        duration = _duration;
        rate = _rate;
        loanExpWeeks = _loanExpWeeks;

    }

    function payToLoan() public payable {
        require(!loanFilledStatus);

        lenders[lenderCount++] = msg.sender;
        loanFill += msg.value;
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
