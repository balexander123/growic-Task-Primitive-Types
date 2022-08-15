pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract YourContract {

    address public owner = 0x2fF7015f8Ea09169883C7F884bc53C123b370F5B;

    struct Student {
        address studentID;
        string name;
        bool valid;
    }

    mapping(address => Student) students;

    constructor() payable {}

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner!");
        _;
    }

    function register(address studentID, string memory name) public onlyOwner {
        require(!students[studentID].valid, "Duplicate student ID");
        Student storage _student = students[studentID];
        _student.studentID = studentID;
        _student.name = name;
        _student.valid = true;
    }

    function getStudentDetails(address studentID) public view {
        require(students[studentID].valid, "Student ID not found");
        Student memory _student = students[studentID];
        console.log("Student name: ", _student.name);
        console.log("Student ID: ", _student.studentID);
    }

    receive() external payable {}

    fallback() external payable {}
}
