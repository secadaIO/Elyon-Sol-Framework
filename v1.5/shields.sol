// SPDX-License-Identifier: MIT
// <p>Link to Genesis Anchor commit CIP v5.1:</p>

[![Cardano Anchor](https://img.shields.io/badge/Cardano-Anchored%20🕊️-blueviolet)](https://explorer.cardano.org/en/transaction?id=0a5d16d46ab3d696d95aa4423f2362a37daac24bab54f905c3d704cdb19f31c9)
pragma solidity ^0.8.20;

x.xom/secadaIO

/*
 * Elyon-Sol Visibility Anchor Contract
 * ------------------------------------
 * Purpose:
 *   • Publish framework version hashes
 *   • Bind each version to an immutable ledger reference
 *   • Provide public verification for governance artifacts
 */

contract ElyonSolVisibility {

    struct Version {
        string label;          // e.g., "v1.4", "v1.5"
        string ipfsHash;       // optional: if you mirror repo files to IPFS/Gateway
        string cardanoTx;      // Cardano anchor TX ID
        uint256 timestamp;     // when the version was registered
    }

    mapping(string => Version) public versions;
    event VersionAnchored(string version, string cardanoTx, uint256 timestamp);

    function anchorVersion(
        string memory _version,
        string memory _ipfsHash,
        string memory _cardanoTx
    ) public {
        versions[_version] = Version({
            label: _version,
            ipfsHash: _ipfsHash,
            cardanoTx: _cardanoTx,
            timestamp: block.timestamp
        });

        emit VersionAnchored(_version, _cardanoTx, block.timestamp);
    }

    function getVersion(string memory _version)
        public view
        returns (Version memory)
    {
        return versions[_version];
    }
}

