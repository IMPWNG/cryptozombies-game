# CryptoZombies-Game
Following the CryptoZombies tutorial with all the comments 


## mapping and address

- mapping : storing organized data . Is a key-value store for storing and looking up data

> mapping (address => uint) public accountBalance; 
> storing a uint that holds the user's accopunt balance> Here, the key is an address and the value a uint 

- address 

## msg.sender

Global variable that is available to all functions. It refers to the address of the person or smartcontract who called the current function.

mapping (address => uint) favoriteNumber; 
function setMyNumber(uint _myNumber) public { 
    favoriteNumbe[msg.sender] = _myNumber; 
}

> Update favoriteNumber mapping to store _myNumber under msg.sender

## require

Stop executing a function if some condittions are not true : 

function sayHiToVitalik(string memory _name) public returns (string memory) {
>    // Compares if _name equals "Vitalik". Throws an error and exits if not true.
>    // (Side note: Solidity doesn't have native string comparison, so we
>    // compare their keccak256 hashes to see if the strings are equal)
require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));
>    // If it's true, proceed with the function:
    return "Hi!";
}