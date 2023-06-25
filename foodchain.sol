// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


 /*///////////////////////////////////////////
//////Contract 3 - User/////////////////////////////////
Holds Details related to Users
////////////////////////////////////////////*/
contract User{
    ///Contract Used to store details of Users
    string public name;
    string public location;
    string public stage;
    //array to hold all smart contracts deployed by a specific User
    string[] public history;
    address public owner=address(0);
    ////events
    event userCreated(string name,address addre);
    constructor(){
        owner=msg.sender;
    }
    /*///////////////////////////////////////////
    //////Signup/////////////////////////////////
    User can join the chain using name,location,
    stage in which they are participating
    ////////////////////////////////////////////*/
    function signup(string memory nme,string memory loc,string memory stg) public {
        name=nme;
        location=loc;
        stage=stg;
        emit userCreated(nme, owner);
    }
    /*///////////////////////////////////////////
    //////getUserData()/////////////////////////////////
    Returns details of a specific User
    ////////////////////////////////////////////*/
    function getUserData() public view returns (string memory ,string memory ,string memory ){
        return (name,location,stage);
    }
}


 /*///////////////////////////////////////////
//////Contract 2 - StepNode/////////////////////////////////
Each step in the process 
////////////////////////////////////////////*/
contract StepNode{
    //Step details
    bool public isLastStep;
    bool public isFirstStep;
    bool public isProcessedStep=false;
    address public stepAddress;
    address public next=address(0);
    address public prev=address(0);
    address public owner;
    uint256 arrayIndex;
    string  public step;
    string public location;
    string public description;
    uint time;
    //////events

    event eventPrintStepData(bool isLastStep,bool isFirstStep,bool isProcessedStep,address next,address prev,address owner,string step,string location,string description,uint time);
    constructor(){
        owner=msg.sender;
        time=block.timestamp;
        stepAddress=address(this);
    }
/*///////////////////////////////////////////
updateNext() - Used to set previous address of a block.
This is done after creating a new step,new step
address is passed to the function
////////////////////////////////////////////*/
    function updateNext(address nextAddress) public {
        next=nextAddress;
       
    }
/*///////////////////////////////////////////
markprocessed() - Mark a block as processed means
no further processing is possible
////////////////////////////////////////////*/
    function markprocessed()public{
         isProcessedStep=true;
        
    }
/*///////////////////////////////////////////
Store() -Store details related to the step
////////////////////////////////////////////*/
    function store(bool lastStep,bool firstStep,address prevAd,uint256 index,string memory stepData,string memory locationData,string memory descriptionData) public {
        isLastStep=lastStep;
        isFirstStep=firstStep;
        prev=prevAd;
        arrayIndex=index;
        location=locationData;
        step=stepData;
        description=descriptionData;
    }
/*///////////////////////////////////////////
isLastStepNode() -Checks whether a given node
is last node or not?
////////////////////////////////////////////*/
    function isLastStepNode()public  view returns (bool){
        return isLastStep;
    }
/*///////////////////////////////////////////
isLastStepNode() -Checks whether a given node
is first node or not?
////////////////////////////////////////////*/
    function isFirstStepNode()public  view returns (bool){
        return isFirstStep;
    }
/*///////////////////////////////////////////
getPrevAddress() -Returns address of previous 
block
////////////////////////////////////////////*/
    function getPrevAddress()public  view returns (address){
        return prev;
    }
/*///////////////////////////////////////////
getNextAddress() -Returns address of next 
block
////////////////////////////////////////////*/
    function getNextAddress()public  view returns (address){
        return next;
    }
/*///////////////////////////////////////////
isProcessed() -Returns a particular block is 
processed or not
////////////////////////////////////////////*/
    function isProcessed() public  view returns (bool){
         return isProcessedStep;
    }
/*///////////////////////////////////////////
setNextAddress() -set next address of a block.Done after 
a new step is created
////////////////////////////////////////////*/
    function setNextAddress(address newAddress) public {
        next=newAddress;
    }
/*///////////////////////////////////////////
purchaseProduct() -Purchase a product.After marking a product
as purchased it's not possible to add a next step
////////////////////////////////////////////*/
    function purchaseProduct() public {
        isLastStep=true;
    }
/*///////////////////////////////////////////
isValidNode() - How?
X-->Y-->Z To create a node Z we have to verify whether
previous node Y is valid or not.We verify it by
checking if next address of X is equal to address of Y.
(If Y is a firstNode no need to check);
////////////////////////////////////////////*/
    function isValidNode() public view returns (bool){
        
        if(!isFirstStep) {
            StepNode previousStep=StepNode(prev);
            address previous=previousStep.getNextAddress();
            if(previous==stepAddress){
                return true;
            }
            return false;
        }
        return  true;
    }
/*///////////////////////////////////////////
nodeData() - Returns all data related to a step/stage
////////////////////////////////////////////*/
    function nodeData() public  returns(bool,bool,bool,address,address,address,string memory,string memory,string memory,uint){
        emit eventPrintStepData(isLastStep,isFirstStep,isProcessedStep,next,prev,owner,step,location,description,time);
        return (isLastStep,isFirstStep,isProcessedStep,next,prev,owner,step,location,description,time);
    }
//////////////////////////////////////////////

/////////////////////
    function nodeAddress() public view returns (address){
        return stepAddress;
    }

}


/*///////////////////////////////////////////
//////Contract 1 - SuplyChain/////////////////////////////////
Act as the parent Contract.Holds all contracts related to the
chain

////////////////////////////////////////////*/
contract SupplyChain{
    User[] public userlist;//Holds all User Contracts
    StepNode[] public stepNodeArray;//Holds all step contracts
    mapping (address=>uint32[]) public addressToArrayindex;
    mapping (address=>User)public userMapping;
//////////
/////Events

    event eventLogMessage(string mssg);//log some text 
    event eventStepCreated(address addr,string mssg);//print log when a new step is created
    event emitError(string reason,string text);

/*///////////////////////////////////////////
createAFirstStep() - Create first step of a product
Only logged in users can create a step
////////////////////////////////////////////*/
    function createAFirstStep(string memory stepData,string memory locationData,string memory descriptionData) public{
        User user=userMapping[msg.sender];
        try user.getUserData(){
                StepNode firstStep=new StepNode();
                stepNodeArray.push(firstStep);
                uint256 len=getArraylength();
                firstStep.store(false, true, address(0),len,stepData,locationData,descriptionData);
                emit eventStepCreated(firstStep.nodeAddress(),"A node created,Node is a first stage");
        }catch Error(string memory reason){
            emit emitError(reason,"Not Logged in");
        }
        
        
    }
/*///////////////////////////////////////////
createAStep() - Returns all data related to a step/stage
////////////////////////////////////////////*/
    function createAStep(address prevAddress,string memory stepData,string memory locationData,string memory descriptionData) public{
        //prevNode Status
        StepNode node=StepNode(prevAddress);
        User user=userMapping[msg.sender];
       
        try user.getUserData(){
                try node.isLastStepNode(){
                        if(node.isLastStepNode()){
                            emit emitError("PURCHASED","already purchased product");
                            revert("Already Purchased");
                        }else if(node.isProcessed()){
                            emit emitError("PROCESSES","already Processed product");
                            revert("Already Processed");
                        }else if(!node.isValidNode()){
                            emit emitError("INVALID_NODE","Invalid node");
                            revert("Invalid node");
                        }else{
                            StepNode newStep=new StepNode();
                            uint256 len=getArraylength();
                            newStep.store(false, false, prevAddress,len,stepData,locationData,descriptionData);
                            stepNodeArray.push(newStep);
                            node.markprocessed();
                            setNextAddressNode(newStep.nodeAddress(),newStep.getPrevAddress());
                            emit eventStepCreated(newStep.nodeAddress(),"A node created,Node is not a first stage");
                        }
                        
                        
                    }catch Error(string memory reason) {
                        // catch failing revert() and require()
                        emit emitError(reason,"Node doesn't exist");
                    }
             
            
        }catch Error(string memory reason){
            emit emitError(reason,"Not loggedIn");
        }
        
       
        
    }
    function setNextAddressNode(address newAdress,address prevAddress) public {
                StepNode prevStep=StepNode(prevAddress);
                prevStep.setNextAddress(newAdress);
                emit eventLogMessage("Address Connected");
    }
    function purchaseProduct(address productAddress) public {
                StepNode step=StepNode(productAddress);
                step.purchaseProduct();
                emit eventLogMessage("product purchased");
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
    function getPrevData(address prevAddress)public view   returns (bool){
        StepNode node=StepNode(prevAddress);
        return address(0)==node.getPrevAddress();
    }
    function getStepDetails(address indexAddress)public  returns (bool,bool,bool,address,address,address,string memory,string memory,string memory,uint){
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