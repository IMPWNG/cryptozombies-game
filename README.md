# CryptoZombies-Game
Following the CryptoZombies tutorial with all the comments 

## State variables & integers

- state variables are permantly sotred in contract storage, is like writting on a DB

contract Example {
>  // Here, we created a uint called myUnsignedInteger and set it equal to 100
  uint myUnsignedInteger = 100;
}

- The **uint** data type is an unsigned integer (value must be non negative)

## Structs

For more complex data type, is allow to create more complicated data types that have multiply properties

## Arrays

When you want a collection of something. 2 types of arrays in Solidity : Fixed and Dynamic

>   // Array with a fixed length of 2 elements:
uint[2] fixedArray;

>   // a dynamic Array - has no fixed size, can keep growing:
uint[] dynamicArray;

## Function Declarations

>   function eatHamburgers(string memory _name, uint _amount) public {}

This is a function named *eatHamburgers* that take 2 parameters : a String and a Uint and also set as Public and _name variable store on memory

## Work with Structs and Arrays

struct Person {
  uint age;
  string name;
}

Person[] public people;

>   // create a New Person:
Person satoshi = Person(172, "Satoshi");

>   // Add that person to the Array:
people.push(satoshi);

> // Combine to keep code clean
people.push(Person(16, "Vitalik"));

*array.push()*  adds something to the end of the array in the order we added them

## Private/Public function

In solidity functions are public by default, anyone can call the contract function and execute the code

uint[] numbers;

function _addToArray(uint _number) private {
  numbers.push(_number);
}

Here, only other functions within our contract will be able to call this function and add the the *numbers* array

## More on Functions

Return values and function modifiers 

string greeting = "What's up dog";

function sayHello() public returns (string memory) {
>   //Return a string
  return greeting;
}

Here, their is no state's change in Solidity so we can use the *view* function for only viewing the data

function sayHello() public view returns (string memory) 

## Keccak256 and Typecasting

## Event

Events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.

>   // declare the event
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public returns (uint) {
  uint result = _x + _y;
>   // fire an event to let the app know the function was called:
  emit IntegersAdded(_x, _y, result);
  return result;
}


## Mapping and address

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

## Require

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
  