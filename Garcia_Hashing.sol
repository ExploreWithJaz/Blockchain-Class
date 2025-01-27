// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hash {

    function getKeccakHashes(
        string memory firstName, 
        string memory lastName, 
        uint256 code, 
        string memory section, 
        string memory day, 
        string memory time, 
        string memory room
    ) public pure returns (bytes32, bytes32) {

        // Directly use operations inside abi.encodePacked to avoid many temporary variables
        return (
            keccak256(abi.encodePacked(
                bytes(firstName)[bytes(firstName).length - 1],  // last char of firstName
                bytes(lastName)[0],  // first char of lastName
                uint8((code / 100) % 10),  // third digit of code
                bytes(section)[bytes(section).length - 1],  // last char of section
                bytes(day)[0],  // first char of day
                uint8(uint8(bytes(time)[1]) - 48),  // second digit of time
                uint8(uint8(bytes(room)[0]) - 48)  // first digit of room
            )),
            keccak256(abi.encodePacked(
                bytes(firstName)[bytes(firstName).length - 1],  // last char of firstName
                bytes(lastName)[0],  // first char of lastName
                uint8((code / 100) % 10),  // third digit of code
                bytes(section)[bytes(section).length - 1],  // last char of section
                bytes(day)[0],  // first char of day
                uint8(uint8(bytes(time)[1]) - 48),  // second digit of time
                uint8(uint8(bytes(room)[0]) - 48)  // first digit of room
            ))
        );
    }
}
