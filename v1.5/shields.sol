// SPDX-License-Identifier: MIT
//
pragma solidity ^0.8.20;

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

