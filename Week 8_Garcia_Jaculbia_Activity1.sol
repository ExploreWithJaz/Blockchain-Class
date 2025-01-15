// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GenerateHash {

    function generateHash(
        string memory firstName, 
        string memory middleName, 
        string memory lastName, 
        string memory gender, 
        uint age
    ) public pure returns (bytes32, bytes32) {
        string memory a = string(abi.encodePacked(bytes(firstName)[0]));
        string memory b = string(abi.encodePacked(bytes(middleName)[bytes(middleName).length - 1]));
        string memory c = string(abi.encodePacked(bytes(lastName)[bytes(lastName).length - 1]));
        string memory d = gender;
        string memory e = string(abi.encodePacked(bytes(uintToString(age))[0]));

        string memory combined = string(abi.encodePacked(a, b, c, d, e));

        bytes32 encodePackedHash = keccak256(abi.encodePacked(combined));

        bytes32 encodeHash = keccak256(abi.encode(combined));

        return (encodePackedHash, encodeHash);
    }

    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint j = v;
        uint length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length;
        while (v != 0) {
            bstr[--k] = bytes1(uint8(48 + v % 10));
            v /= 10;
        }
        return string(bstr);
    }
}
