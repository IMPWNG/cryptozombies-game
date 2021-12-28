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

>   // (Side note: Solidity doesn't have native string comparison, so we compare their keccak256 hashes to see if the strings are equal)

require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));

>    // If it's true, proceed with the function:

    return "Hi!";
}

## Inheritance

Good to use to add some logic in our work. Such as **Cat** is an **Animal** for subclass

contract Doge {
  function catchphrase() public returns (string memory) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string memory) {
    return "Such Moon BabyDoge";
  }
}

> Here BabyDioge inherits from Doge. That means if you compile and deploy BabyDoge, it will have access to both catchphrase() and anotherCatchphrase() (and any other public functions we may define on Doge).

## Import

Put in the same directory that all your other contract. 

## Storage vs Memory (data location - (HDD vs RAM))

- storage refers to variable that are permanently stored on the blockchain
- memory  for temporary one and are erased between external function calls to your contract - when the function call ends
  