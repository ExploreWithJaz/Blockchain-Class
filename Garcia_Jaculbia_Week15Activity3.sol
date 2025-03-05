// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GradesNFT is ERC1155, Ownable {
    // Grade Constants
    uint256 public constant EXCELLENT = 1;
    uint256 public constant VERY_GOOD = 2;
    uint256 public constant GOOD = 3;
    uint256 public constant FAIR = 4;
    uint256 public constant POOR = 5;

    // Mapping grade IDs to grade names
    mapping(uint256 => string) private gradeNames;

    // Event to log the assigned grade
    event GradeAssigned(address indexed student, uint256 score, uint256 gradeID, string gradeName);

    constructor() ERC1155("https://mygrades.io/api/item/{id}.json") Ownable(msg.sender) {
        // Set grade names for readability
        gradeNames[EXCELLENT] = "Excellent";
        gradeNames[VERY_GOOD] = "Very Good";
        gradeNames[GOOD] = "Good";
        gradeNames[FAIR] = "Fair";
        gradeNames[POOR] = "Poor";
    }

    // Function to mint a grade NFT based on a student's score
    function mintGradeNFT(address student, uint256 score) external onlyOwner {
        uint256 gradeID = getGradeID(score);
        require(gradeID != 0, "Invalid score");

        _mint(student, gradeID, 1, ""); // Mint 1 NFT of the determined grade

        // Emit the GradeAssigned event
        emit GradeAssigned(student, score, gradeID, gradeNames[gradeID]);
    }

    // Function to get the grade ID based on the score
    function getGradeID(uint256 score) public pure returns (uint256) {
        if (score >= 90 && score <= 100) {
            return EXCELLENT;
        } else if (score >= 81 && score < 90) {
            return VERY_GOOD;
        } else if (score >= 75 && score < 81) {
            return GOOD;
        } else if (score >= 71 && score < 75) {
            return FAIR;
        } else if (score < 71) {
            return POOR;
        }
        return 0; // Invalid score case
    }

    // Function to return the grade name by token ID
    function getGradeName(uint256 gradeID) external view returns (string memory) {
        require(bytes(gradeNames[gradeID]).length > 0, "Invalid grade ID");
        return gradeNames[gradeID];
    }
}
