// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StepNode{
    bool public isLastStep;
    bool public isFirstStep;
    address public next=address(0);
    address public prev;
    address public owner=msg.sender;
    uint256 arrayIndex;

    function updateNext(address nextAddress) public {
        next=nextAddress;
    }
    function store(bool lastStep,bool firstStep,address prevAd,uint256 index) public {
        isLastStep=lastStep;
        isFirstStep=firstStep;
        prev=prevAd;
        arrayIndex=index;
    }
    function isLastStepNode()public  view returns (bool){
        return isLastStep;
    }
    function isProcessed()public  view returns (bool){
        if(next==address(0)){
            return false;
        }
         return true;
    }
    function setNextAddress(address newAddress) public {
        next=newAddress;
    }
    function purchaseProduct() public {
        isLastStep=true;
    }
    function nodeData() public view returns(bool,bool,address,address,address){
        return (isLastStep,isFirstStep,next,prev,owner);
    }

}

contract SupplyChain{

    StepNode[] public stepNodeArray;
    mapping (address=>uint32[]) public addressToArrayindex;
    event emitError(string reason);
    function createAFirstStep() public{
        StepNode firstStep=new StepNode();
        stepNodeArray.push(firstStep);
        uint256 len=getArraylength();
        firstStep.store(false, true, address(0),len);
        
    }

    function createAStep(address prevAddress) public{
        //prevNode Status
        StepNode node=StepNode(prevAddress);
        if(prevAddress==address(0)){
             revert("Invalid Parameters");
        }   
        try node.isLastStepNode(){
            if(node.isLastStepNode()){
                revert("Already Purchased");
            }else if(node.isLastStepNode()){
                revert("Already Purchased");
            }else if(node.isProcessed()){
                revert("Already Processed");
            }else{
                StepNode newStep=new StepNode();
                uint256 len=getArraylength();
                newStep.store(false, false, prevAddress,len);
                stepNodeArray.push(newStep);
                
            }
        }catch Error(string memory reason) {
            // catch failing revert() and require()
            emit emitError(reason);
        }
       
        
    }
    function setNextAddressNode(address newAdress,address prevAddress) public {
                StepNode prevStep=StepNode(prevAddress);
                prevStep.setNextAddress(newAdress);
    }
    function purchaseProduct(address productAddress) public {
                StepNode step=StepNode(productAddress);
                step.purchaseProduct();
    }
    function getArraylength() public view returns (uint256) {
        return stepNodeArray.length;
    }
    function getStep(uint256 index)public view returns (StepNode){
        return stepNodeArray[index];
    }
    function getStepFromAddress(address indexAddress)public pure returns (StepNode){
        StepNode node=StepNode(indexAddress);
        return node;
    }
    struct Data{
            bool isLastStep;
            bool isFirstStep;
            address next;
            address prev;
            address owner;
            uint256 arrayIndex;
    }
    

    function getStepDetails(address indexAddress)public view returns (bool,bool,address,address,address){
        StepNode node=StepNode(indexAddress);
        return  node.nodeData();
    }
}