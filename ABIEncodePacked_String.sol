pragma solidity ^0.5.0;

contract ABIEncodePacked_String {
    function toString() public returns(string memory) {
        bytes8 data = 0x4141414142424242;
        bytes memory encodedData = abi.encodePacked('AAAA','BBBB');
        return string(encodedData);     // return string(data) will result in error. Direct conversion from bytes8 to string is not allowed
    }
    
    function toABIEncodePacked() public returns(bytes memory) {
        return abi.encodePacked('AAAA','BBBB');
    }
}