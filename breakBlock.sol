pragma solidity ^0.8.0;

contract breakBlock{

    string flag = "flag{br3ak_Bl0ck}";
    bytes32 firstBlock;
    uint tryBreak = 0;
    uint internal prob;

    constructor() {
        prob = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender))) % getByteToUint(0x64);
        firstBlock = keccak256(abi.encode(prob));
    }
    modifier maxTry(){
        if(tryBreak > 3){
            revert();
        }
        _;
    }

    function generateBlock(uint _b) internal view returns(bytes32) {
        uint toInt = uint(firstBlock);
        uint newCount = uint(toInt % getByteToUint(0x64));
        return bytes32(keccak256(abi.encodePacked(_b, newCount)));
    }

    function generateNum() internal view returns(uint){
        return block.number - (getByteToUint(0x0a) - getByteToUint(0x9));
    }

    function setBlock(bytes32 _response) public maxTry returns(string memory){
        bytes32 newBlock = bytes32(generateBlock(generateNum()));
        if(canBreak(newBlock, _response) == false){
            return "Rater";
        }
        else{
            return flag;
        }
    }

    function canBreak(bytes32 _block, bytes32 _resp) private returns(bool){
        if(_block == _resp){
            return true;
        }
        else{
            tryBreak++;
            return false;
        }
    }
    function getByteToUint(uint256 _bytes) internal view returns(uint256){
        return uint256(_bytes);
    }
}
