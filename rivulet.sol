// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Rivulet {
    //royal address
    address payable public royal;
    // user balances;
    mapping(string => uint) balances;

    error onlyRoyal();


    constructor (
        address payable royalAddress
        ) {
     royal = royalAddress;
     }

    //deposit
    //pay money to our wallet and save user's balance to slug
    function deposit(string memory slug) public payable returns(bool) {
        balances[slug] += msg.value;
        royal.transfer(msg.value);

        return true;
    }

    function withdraw(string memory slug,  address payable beneficiary) public payable {
        if (msg.sender != royal) {
            revert onlyRoyal();
        }
        if (balances[slug] < msg.value) {
            revert("Insufficient balance");
        }
        balances[slug] -= msg.value;
        beneficiary.transfer(msg.value);
    }

    function balance (string memory slug) public view returns (uint) {
        return balances[slug];
    }


    //payout
}