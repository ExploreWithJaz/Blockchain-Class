// SPDX-License-Identifier: HAU
pragma solidity ^0.8.0;

contract Computation {
    int numUnits;
    int ratePerUnit = 620;
    int labFee = 2000;
    int enrollmentFee;
    int miscellanous = 1562;
    int modePayment;
    int tuitionFee;
    int interestRate;


    constructor(int _numUnits, int _ratePerUnit, int _modePayment) {
        numUnits = _numUnits;
        ratePerUnit = _ratePerUnit;
        modePayment = _modePayment;
        interestRate = calculateInterestRate(_modePayment);
    }

    function calculateInterestRate(int _modePayment) private pure returns (int) {
        if(_modePayment == 1) {
            return 10;
        }else if (_modePayment == 2) {
            return 5;
        }else if (_modePayment == 3) {
            return 10;
        }else {
            revert("Invalid mode of Payment"); 
        }
    }

    function calculateTotalInterestRate() private view returns (int) {
        return (totalCalculatedTuitionFee() * interestRate) - totalCalculatedTuitionFee();
    }

    function calculateEnrollmentFee() private view returns (int) {
        return (numUnits * ratePerUnit);
    }

    function calculateTuitonFee() private view returns (int) {
        return calculateEnrollmentFee() + miscellanous + labFee;
    }

    function totalCalculatedTuitionFee() private view returns (int) {
        return calculateTuitonFee() * modePayment;
    }

    function getDetails() public view returns (int, int, int, int, int, int, int, int) {
        int totalEnrollmentFee = calculateEnrollmentFee();
        int totalTuitionFee = calculateTuitonFee();
        int totalCalculatedTuitionFeeAfterInterest = calculateTotalInterestRate();
        return (numUnits, ratePerUnit, totalEnrollmentFee, miscellanous, labFee, totalTuitionFee, modePayment, totalCalculatedTuitionFeeAfterInterest);
    }
}