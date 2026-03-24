// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@layerzerolabs/lz-evm-sdk-v1-0.7/contracts/lzApp/NonblockingLzApp.sol";

contract CrossChainMessenger is NonblockingLzApp {
    string public lastReceivedMessage;
    
    event MessageSent(string message);
    event MessageReceived(string message);

    constructor(address _endpoint) NonblockingLzApp(_endpoint) {}

    // 1. Sending the message
    function sendMessage(
        uint16 _dstChainId, 
        string calldata _message, 
        bytes calldata _adapterParams
    ) public payable {
        bytes memory payload = abi.encode(_message);
        
        // Estimate fees
        (uint nativeFee, ) = lzEndpoint.estimateFees(_dstChainId, address(this), payload, false, _adapterParams);
        require(msg.value >= nativeFee, "Insufficient gas for cross-chain fee");

        _lzSend(
            _dstChainId, 
            payload, 
            payable(msg.sender), 
            address(0x0), 
            _adapterParams, 
            msg.value
        );

        emit MessageSent(_message);
    }

    // 2. Receiving the message (Internal callback)
    function _nonblockingLzReceive(
        uint16 _srcChainId, 
        bytes memory _srcAddress, 
        uint64 _nonce, 
        bytes memory _payload
    ) internal override {
        string memory message = abi.decode(_payload, (string));
        lastReceivedMessage = message;
        emit MessageReceived(message);
    }

    // Allow owner to withdraw excess gas fees
    function withdraw() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
