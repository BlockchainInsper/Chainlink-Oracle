// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import '@chainlink/contracts/src/v0.8/ChainlinkClient.sol';
import '@chainlink/contracts/src/v0.8/ConfirmedOwner.sol';

/**
 * Request testnet LINK and ETH here: https://faucets.chain.link/
 * Find information on LINK Token Contracts and get the latest ETH and LINK faucets here: https://docs.chain.link/docs/link-token-contracts/
 */

contract Oracle is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    uint256 private _rate;

    uint256 private _decimals;
    bytes32 private _jobId;
    uint256 private _fee;
    string private _reqURL;
    string private _path;

    /**
     * @notice Initialize the link token and target oracle
     *
     * Goerli Testnet details:
     * Link Token: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     * Oracle: 0xCC79157eb46F5624204f47AB42b3906cAA40eaB7 (Chainlink DevRel)
     * _jobId: ca98366cc7314957b8c012c72f05aeeb
     *
     */
    constructor(string memory reqURL_, string memory path_, uint256 decimals_) ConfirmedOwner(msg.sender) {
        setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
        setChainlinkOracle(0xCC79157eb46F5624204f47AB42b3906cAA40eaB7);

        _decimals = decimals_;
        _reqURL = reqURL_;
        _path = path_;
        _jobId = 'ca98366cc7314957b8c012c72f05aeeb';
        _fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
    }

    function requestRate() public returns(bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfill.selector);
        req.add('get', _reqURL);

        req.add('path', _path);

        int256 timesAmount = int(10**_decimals);
        req.addInt('times', timesAmount);

        return sendChainlinkRequest(req, _fee);
    }

    function fulfill(bytes32 requestId, uint256 rate_) public recordChainlinkFulfillment(requestId) {
        _rate = rate_;
    }

    function rate() public view returns(uint256) {
        return _rate;
    }

    function path() public view returns(string memory) {
        return _path;
    }

    function reqURL() public view returns(string memory) {
        return _reqURL;
    }

    function decimals() public view returns(uint256) {
        return _decimals;
    }
}
