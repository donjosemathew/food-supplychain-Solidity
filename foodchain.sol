// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract User{
    string public name;
    string public location;
    string public stage;
    string[] public history;
     address public owner=address(0);
    constructor(){
        owner=msg.sender;
    }
    function signup(string memory nme,string memory loc,string memory stg) public {
        name=nme;
        location=loc;
        stage=stg;
    }
    function getUserData() public view returns (string memory ,string memory ,string memory ){
        return (name,location,stage);
    }
}
contract StepNode{
    bool public isLastStep;
    bool public isFirstStep;
    bool public isProcessedStep=false;
    address public next=address(0);
    address public prev;
    address public owner;
    uint256 arrayIndex;
    string  public step;
    string public location;
    string public description;
    uint time;
    constructor(){
        owner=msg.sender;
        time=block.timestamp;
    }
    function updateNext(address nextAddress) public {
        next=nextAddress;
        isProcessedStep=true;
    }
    function store(bool lastStep,bool firstStep,address prevAd,uint256 index,string memory stepData,string memory locationData,string memory descriptionData) public {
        isLastStep=lastStep;
        isFirstStep=firstStep;
        prev=prevAd;
        arrayIndex=index;
        location=locationData;
        step=stepData;
        description=descriptionData;
    }
    function isLastStepNode()public  view returns (bool){
        return isLastStep;
    }
    function isFirstStepNode()public  view returns (bool){
        return isFirstStep;
    }
    function isProcessed() public  view returns (bool){
         return isProcessedStep;
    }
    function setNextAddress(address newAddress) public {
        next=newAddress;
    }
    function purchaseProduct() public {
        isLastStep=true;
    }
    function nodeData() public view returns(bool,bool,address,address,address,string memory,string memory,string memory,uint){
        return (isLastStep,isFirstStep,next,prev,owner,step,location,description,time);
    }

}

contract SupplyChain{
    User[] public userlist;
    StepNode[] public stepNodeArray;
    mapping (address=>uint32[]) public addressToArrayindex;
    mapping (address=>User)public userMapping;
    event emitError(string reason,string text);
    function createAFirstStep(string memory stepData,string memory locationData,string memory descriptionData) public{
        User user=userMapping[msg.sender];
        try user.getUserData(){
                StepNode firstStep=new StepNode();
                stepNodeArray.push(firstStep);
            uint256 len=getArraylength();
            firstStep.store(false, true, address(0),len,stepData,locationData,descriptionData);
        }catch Error(string memory reason){
            emit emitError(reason,"Not Logged in");
        }
        
        
    }

    function createAStep(address prevAddress,string memory stepData,string memory locationData,string memory descriptionData) public{
        //prevNode Status
        StepNode node=StepNode(prevAddress);
        User user=userMapping[msg.sender];
       
        try user.getUserData(){
            
        }catch Error(string memory reason){
            emit emitError(reason,"Not loggedIn");
        }
        if(prevAddress==address(0)){
             revert("Invalid Parameters");
        }   
        try node.isLastStepNode(){
            if(node.isLastStepNode()){
                revert("Already Purchased");
            }else if(node.isLastStepNode()){
                revert("Already Purchased");
            }else if(node.isProcessed() || !node.isFirstStep()){
                revert("Already Processed");
            }else{
                StepNode newStep=new StepNode();
                uint256 len=getArraylength();
                newStep.store(false, false, prevAddress,len,stepData,locationData,descriptionData);
                stepNodeArray.push(newStep);
                
            }
        }catch Error(string memory reason) {
            // catch failing revert() and require()
            emit emitError(reason,"Node doesn't exist");
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
    function getStepDetails(address indexAddress)public view returns (bool,bool,address,address,address,string memory,string memory,string memory,uint){
        StepNode node=StepNode(indexAddress);
        return  node.nodeData();
    }
    function userSignup(string memory nme,string memory loc,string memory stg)public {
        User newUser=new User();
        newUser.signup(nme, loc, stg);
        userMapping[msg.sender]=(newUser);
    }
    function getUserData(address userAd) public view returns (string memory ,string memory ,string memory ){
       User userObject=userMapping[userAd];
       return userObject.getUserData() ;     
    }
   
}