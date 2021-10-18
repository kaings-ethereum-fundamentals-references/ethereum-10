pragma solidity ^0.8.0;

contract MultiSigWallet {
    address[] public owners;
    uint public minNumOfApprovals;
    
    struct Transfer {
        uint _transferId;
        uint _amount;
        address payable _beneficiary;
        bool _isSent;
        uint _numOfApprovals;
    }
    
    Transfer[] transferReqs;
    mapping(address => mapping(uint => bool)) public ownersApprovalState;   //ownersApprovalState[address][transferId] -> bool
    
    modifier onlyOwners() {
        bool isOwner = false;
        for (uint i=0; i<owners.length; i++) {
            if(owners[i] == msg.sender) {
                isOwner = true;
                break;
            }
        }
        require(isOwner, "You are not authorised!!!!!");
        _;
    }
    
    constructor(address[] memory _owners, uint _minNumOfApprovals) {
        require(_minNumOfApprovals <= _owners.length, "min. number of approvals incorrect!!!!!");
        owners = _owners;
        minNumOfApprovals = _minNumOfApprovals;
    }
    
    function deposit() public payable {}
    
    function createTransfer(uint _amount, address payable _beneficiary) public onlyOwners {
        Transfer memory transfer = Transfer(transferReqs.length, _amount, _beneficiary, false, 0);
        transferReqs.push(transfer);
    }
    
    function approve(uint _transferId) public onlyOwners {
        require(!ownersApprovalState[msg.sender][_transferId], "Approval is only allowed once per address!");
        require(!transferReqs[_transferId]._isSent, "This transfer is not valid!");
        
        ownersApprovalState[msg.sender][_transferId] = true;
        transferReqs[_transferId]._numOfApprovals++;
        
        if(transferReqs[_transferId]._numOfApprovals >= minNumOfApprovals) {
            transferReqs[_transferId]._isSent = true;
            transferReqs[_transferId]._beneficiary.transfer(transferReqs[_transferId]._amount);
        }
    }
    
    function getTransferReqs() public view returns(Transfer[] memory) {
        return transferReqs;        
    }
    
}