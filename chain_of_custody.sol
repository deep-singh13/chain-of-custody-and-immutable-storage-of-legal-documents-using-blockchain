// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


import "hardhat/console.sol";

contract ChainOfCustody {
    struct Evidence {
        string name;
        uint256 dateTime;
        string receivedFrom;
    }
    
    mapping(uint256 => Evidence[]) private custodyRecords;
    uint256[] private evidenceIds;

    event EvidenceTransferred(
        uint256 indexed evidenceId,
        string name,
        uint256 dateTime,
        string receivedFrom
    );

    function addEvidenceTransfer(
        uint256 evidenceId,
        string memory name,
        string memory receivedFrom
    ) public {
        if (custodyRecords[evidenceId].length == 0) {
            evidenceIds.push(evidenceId);
        }

        Evidence memory newEvidence = Evidence({
            name: name,
            dateTime: block.timestamp,
            receivedFrom: receivedFrom
        });
        
        custodyRecords[evidenceId].push(newEvidence);
        
        emit EvidenceTransferred(evidenceId, name, block.timestamp, receivedFrom);


        console.log("Evidence added - ID:", evidenceId);
        console.log("Name:", name);
        console.log("DateTime:", block.timestamp);
        console.log("Received From:", receivedFrom);
    }

    function displayEvidenceHistory(uint256 evidenceId) public view {
        Evidence[] memory transfers = custodyRecords[evidenceId];
        require(transfers.length > 0, "No transfers found for this evidence ID.");

        for (uint256 i = 0; i < transfers.length; i++) {
            Evidence memory transfer = transfers[i];


            console.log("Evidence ID:", evidenceId);
            console.log("Name:", transfer.name);
            console.log("DateTime:", transfer.dateTime);
            console.log("Received From:", transfer.receivedFrom);
        }

    }

    
}

