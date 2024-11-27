// SPDX-License-Identifier: HAU
pragma solidity ^0.8.0;

contract countOddEven {
    int public oddNumberX;
    int public oddNumberY;

    function countNum(int x, int y) public {
        oddNumberX = countOdd(x);
        oddNumberY = countEven(y);
    }
    function countOdd(int x) internal pure returns (int) {
        return (x + 1) / 2;
    }
    function countEven(int y) internal pure returns (int) {
        return y / 2;
    }
}