// SPDX-License-Identifier: HAU
pragma solidity ^0.8.0;

contract NumberValidation {
    int public num1;
    int public num2;
    int public answer;
    
    function countNum(int countNum1, int countNum2) public {
        num1 = validateNum1(countNum1); 
        num2 = validateNum2(countNum2); 
        answer = num2 ** uint(num1); 
    }

    function validateNum1(int countNum1) internal pure returns (int) {
        require(countNum1 >= 5 && countNum1 <= 10, "The number must be between 5 - 10");
        return countNum1;
    }

    function validateNum2(int countNum2) internal pure returns (int) {
        require(countNum2 >= 1 && countNum2 <= 5, "The number must be between 1 - 5");
        return countNum2;
    }
}
