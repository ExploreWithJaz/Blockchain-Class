// SPDX-License-Identifier: HAU
pragma solidity ^0.8.0;

contract Computation {
    string public Name;
    int public PrincipalAmount;
    int public interestRate;
    int public NumYears;

    constructor(string memory _Name, int _PrincipalAmount, int _NumYears) {
        Name = _Name;
        PrincipalAmount = _PrincipalAmount;
        NumYears = _NumYears;
        interestRate = calculateInterestRate(_PrincipalAmount);
    }

    function calculateInterestRate(int _Principal) public pure returns (int) {
        if(_Principal >= 30000 && _Principal <= 50000) {
            return 755;
        }else if (_Principal >= 50001 && _Principal <= 70000) {
            return 875;
        }else if (_Principal >= 70001 && _Principal <= 88000) {
            return 1123;
        } else if (_Principal >= 88001) {
            return 1375;
        }else {
            revert("Invalid Principal Amount");
        }
    }

    function calculateTotalInterestRate() public view returns (int) {
        return (PrincipalAmount * interestRate / 10000) * NumYears;
    }

    function calculateIntrestPerAnnum() public view returns (int) {
        return (PrincipalAmount * interestRate / 10000);
    }

    function calculateTotalAmount() public view returns (int) {
        return PrincipalAmount + calculateTotalInterestRate();
    }

    function calculateAmortization() public view returns (int) {
        return calculateTotalAmount() / (NumYears * 12);
    }

    function getDetails() public view returns (string memory, int, int, int, int, int, int, int) {
        int totalInterest = calculateTotalInterestRate();
        int totalAmount = calculateTotalAmount();
        int totalInterestPerAnnum = calculateIntrestPerAnnum();
        int monthlyAmortization = calculateAmortization();
        return (Name, PrincipalAmount, interestRate, totalInterestPerAnnum , NumYears ,totalInterest, totalAmount, monthlyAmortization);
    }



}