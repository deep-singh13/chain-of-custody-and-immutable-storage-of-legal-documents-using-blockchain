// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract DocumentStorage {
    struct Document {
        string name;
        string ipfsHash; // IPFS hash for retrieving document
        address owner;
        uint256 timestamp;
    }

    mapping(string => Document) private documents; // Maps IPFS hash to Document struct
    event DocumentStored(string name, string ipfsHash, address indexed owner, uint256 timestamp);

    /**
     * @dev Stores the IPFS hash of a document
     * @param name Name of the document
     * @param ipfsHash IPFS hash of the document for retrieving
     */
    function storeDocument(string memory name, string memory ipfsHash) public {
        require(bytes(documents[ipfsHash].ipfsHash).length == 0, "Document already stored");

        documents[ipfsHash] = Document({
            name: name,
            ipfsHash: ipfsHash,
            owner: msg.sender,
            timestamp: block.timestamp
        });

        emit DocumentStored(name, ipfsHash, msg.sender, block.timestamp);
    }
/**
 * @dev Retrieves document metadata by its IPFS hash
 * @param ipfsHash IPFS hash of the document to retrieve
 * @return name The name of the document
 * @return docIpfsHash The IPFS hash of the document
 * @return owner The address of the document owner
 * @return timestamp The timestamp of when the document was stored
 */
function getDocument(string memory ipfsHash) public view returns (string memory name, string memory docIpfsHash, address owner, uint256 timestamp) {
    require(bytes(documents[ipfsHash].ipfsHash).length != 0, "Document not found");

    Document memory doc = documents[ipfsHash];
    return (doc.name, doc.ipfsHash, doc.owner, doc.timestamp);
}

}
