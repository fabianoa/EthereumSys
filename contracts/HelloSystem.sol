pragma solidity ^0.4.2;

contract HelloSystem {

    address owner;
   
    //Constructor
    function HelloSystem(){
        owner = msg.sender;
    }

    function remove(){
        if(msg.sender == owner){
            selfdestruct(owner);
        }
    }

    function greet() constant returns (string){
        return 'Olá pessoal'; 
    }


}

contract HelloFactory {

    function createHS() returns (address hsAddr) {
        return address(new HelloSystem());
    }

    function deleteHS(address hs){
        HelloSystem(hs).remove();
    }
}