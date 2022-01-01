# CryptoZombies-Game
Following the CryptoZombies tutorial with all the comments 

## State variables & integers

- state variables are permantly sotred in contract storage, is like writting on a DB

````
contract Example {
// Here, we created a uint called myUnsignedInteger and set it equal to 100
  uint myUnsignedInteger = 100;
}
````

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

````
function eatHamburgers(string memory _name, uint _amount) public {

}
````

This is a function named *eatHamburgers* that take 2 parameters : a String and a Uint and also set as Public and _name variable store on memory

## Work with Structs and Arrays

````
struct Person {
  uint age;
  string name;
}

Person[] public people;

// create a New Person:
Person satoshi = Person(172, "Satoshi");

// Add that person to the Array:
people.push(satoshi);

// Combine to keep code clean
people.push(Person(16, "Vitalik"));

````

*array.push()*  adds something to the end of the array in the order we added them

## Private/Public function

In solidity functions are public by default, anyone can call the contract function and execute the code

````
uint[] numbers;

function _addToArray(uint _number) private {
  numbers.push(_number);
}

````

Here, only other functions within our contract will be able to call this function and add the the *numbers* array

## More on Functions

Return values and function modifiers 

````
string greeting = "What's up dog";

function sayHello() public returns (string memory) {
//Return a string
  return greeting;
}
````

Here, their is no state's change in Solidity so we can use the *view* function for only viewing the data

````
function sayHello() public view returns (string memory) 
````

## Keccak256 and Typecasting

## Event

Events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.

>   // declare the event
event IntegersAdded(uint x, uint y, uint result);

````
function add(uint _x, uint _y) public returns (uint) {
  uint result = _x + _y;
// fire an event to let the app know the function was called:
  emit IntegersAdded(_x, _y, result);
  return result;
}
````

## Mapping and address

- mapping : storing organized data . Is a key-value store for storing and looking up data

> mapping (address => uint) public accountBalance; 
> storing a uint that holds the user's accopunt balance> Here, the key is an address and the value a uint 

- address 

## msg.sender

Global variable that is available to all functions. It refers to the address of the person or smartcontract who called the current function.

````
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public { 
    favoriteNumbe[msg.sender] = _myNumber; 
}

````

> Update favoriteNumber mapping to store _myNumber under msg.sender

## Require

Stop executing a function if some condittions are not true : 

````
function sayHiToVitalik(string memory _name) public returns (string memory) {

// Compares if _name equals "Vitalik". Throws an error and exits if not true.

// (Side note: Solidity doesn't have native string comparison, so we compare their keccak256 hashes to see if the strings are equal)

require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));

// If it's true, proceed with the function:

return "Hi!";

}

````

## Inheritance

Good to use to add some logic in our work. Such as **Cat** is an **Animal** for subclass

````
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

````

> Here BabyDioge inherits from Doge. That means if you compile and deploy BabyDoge, it will have access to both catchphrase() and anotherCatchphrase() (and any other public functions we may define on Doge).

## Import

Put in the same directory that all your other contract. 

## Storage vs Memory (data location - (HDD vs RAM))

- storage refers to variable that are permanently stored on the blockchain
- memory  for temporary one and are erased between external function calls to your contract - when the function call ends
  
## Function Visibility 

In addition to *public* and *external* we also have *internal* and *external*

- internal is the same as private but it's accessible to contracts that inherit form this contract 

- exertnal is the same as public but theses functions can only be called outside the contract

````
contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string memory) {
    baconSandwichesEaten++;
// We can call this here because it's internal
    eat();
  }
}

````

## Interface

Here, anyone could store their lucky number and it would be associated with their Eth address. Anyone could aslo look up that person's lucky number using their address.

````
contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}
````

External contract that wanted to read the data using the *getNum* function.

For that, we have to to define an *interafce* of the LuckyNumber contract.

````
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}

````

Now, we can use it in a contract such as : 

````
contract MyContract {
  address NumberInterfaceAddress = 0xab38... 
  // ^ The address of the FavoriteNumber contract on Ethereum
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);
  // Now `numberContract` is pointing to the other contract

  function someFunction() public {
    // Now we can call `getNum` from that contract:
    uint num = numberContract.getNum(msg.sender);
    // ...and do something with `num` here
  }
}

````
Our contract can interact with any other contract as long they expose those function as *public* or 
*external*

## Hnading Mutliple Return Values

````

function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}

function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // This is how you do multiple assignment:
  (a, b, c) = multipleReturns();
}

// Or if we only cared about one of the values:
function getLastReturnValue() external {
  uint c;
  // We can just leave the other fields blank:
  (,,c) = multipleReturns();
}

````
## IF statements 

````
function eatBLT(string memory sandwich) public {
  // Remember with strings, we have to compare their keccak256 hashes
  // to check equality
  if (keccak256(abi.encodePacked(sandwich)) == keccak256(abi.encodePacked("BLT"))) {
    eat();
  }
}

````

## Immutablity of Contracts

## Ownable contracts 

By making the contract *Ownable*, only the owner has privileges 

````

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address private _owner;

  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() internal {
    _owner = msg.sender;
    emit OwnershipTransferred(address(0), _owner);
  }

  /**
   * @return the address of the owner.
   */
  function owner() public view returns(address) {
    return _owner;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isOwner() public view returns(bool) {
    return msg.sender == _owner;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing to ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0));
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

````
Here, *constructor()* is an optional special function wich as the same name as the contract, executed one time when the contract is created.

*modifier onlyOwner()* is like an half-function used to modify other functions to check some requirements prior to execution . In the example above *onlyOwner* can be used to limit acces so only the OWNER of the contract can run this function.

So *OWNABLE* contact does the following : 

- When the contract is created, its constructor set owner to msg.sender (the person who deployed it)
- Adds *onlyOwner* modifier for restrict access to certain function to only the owner
- IT allos to transfer the contract to a new owner

onlyOwner is such a common requirement for contracts that most Solidity DApps start with a copy/paste of this Ownable contract, and then their first contract inherits from it.


## Function modifiers

Just like a function but uses the keyword modifier instead

## Gas

Gas otpimization for function execution 

Inside structs : 

If you have multiple uints inside a struct, using a smaller-sized uint when possible will allow Solidity to pack these variables together to take up less storage. For example:

````
struct NormalStruct {
  uint a;
  uint b;
  uint c;
}

struct MiniMe {
  uint32 a;
  uint32 b;
  uint c;
}

// `mini` will cost less gas than `normal` because of struct packing
NormalStruct normal = NormalStruct(10, 20, 30);
MiniMe mini = MiniMe(10, 20, 30); 

````

For example, a struct with fields uint c; uint32 a; uint32 b; will cost less gas than a struct with fields uint32 a; uint c; uint32 b; because the uint32 fields are clustered together.

## time units

Solidity provides some native units for dealing with time.

The variable now will return the current unix timestamp of the latest block (the number of seconds that have passed since January 1st 1970). The unix time as I write this is 1515527488.

Solidity also contains the time units seconds, minutes, hours, days, weeks and years. These will convert to a uint of the number of seconds in that length of time. So 1 minutes is 60, 1 hours is 3600 (60 seconds x 60 minutes), 1 days is 86400 (24 hours x 60 minutes x 60 seconds), etc.

````

uint lastUpdated;

// Set `lastUpdated` to `now`
function updateTimestamp() public {
  lastUpdated = now;
}

// Will return `true` if 5 minutes have passed since `updateTimestamp` was 
// called, `false` if 5 minutes have not passed
function fiveMinutesHavePassed() public view returns (bool) {
  return (now >= (lastUpdated + 5 minutes));
}

````

## Public Functions & Security

An important security practice is to examine all your public and external functions, and try to think of ways users might abuse them. Remember — unless these functions have a modifier like onlyOwner, any user can call them and pass them any data they want to.

## Function modifiers with arguments

````

// A mapping to store a user's age:
mapping (uint => uint) public age;

// Modifier that requires this user to be older than a certain age:
modifier olderThan(uint _age, uint _userId) {
  require(age[_userId] >= _age);
  _;
}

// Must be older than 16 to drive a car (in the US, at least).
// We can call the `olderThan` modifier with arguments like so:
function driveCar(uint _userId) public olderThan(16, _userId) {
  // Some function logic
}

````
You can see here that the olderThan modifier takes arguments just like a function does. And that the driveCar function passes its arguments to the modifier.

Let's try making our own modifier that uses the zombie level property to restrict access to special abilities.

## Saving Gas with View Functions 

View functions don't cost any gas when they're called externally by a user. This is because view functions don't actually change anything on the blockchain. they only read the data. So marking a function with view tells web3.js that it only needs to query your local Ethereum node to run the function, and it doesn't actually have to create a transaction on the blockchain (which would need to be run on every single node, and cost gas).

If a view function is called internally from another function in the same contract that is not a view function, it will still cost gas. This is because the other function creates a transaction on Ethereum, and will still need to be verified from every node. So view functions are only free when they're called externally.

## Storage costs

Every time you write or change a piece of data, it’s written permanently to the blockchain.
In order to keep costs down, you want to avoid writing data to storage except when absolutely necessary. Sometimes this involves seemingly inefficient programming logic — like rebuilding an array in memory every time a function is called instead of simply saving that array in a variable for quick lookups.

In most programming languages, looping over large data sets is expensive. But in Solidity, this is way cheaper than using storage if it's in an external view function, since view functions don't cost your users any gas. (And gas costs your users real money!).

We'll go over for loops in the next chapter, but first, let's go over how to declare arrays in memory.

## Declaring arrays in memory

We can use *memory* with arrays to create a new array inside a function without needing to write anything to storage. It will only exist until the end of the function call and its lot cheaper gas-wise than updating an array in storage its free if it's a view function called externally.

````
function getArray() external pure returns(uint[] memory) {
  // Instantiate a new array in memory with a length of 3
  uint[] memory values = new uint[](3);

  // Put some values to it
  values[0] = 1;
  values[1] = 2;
  values[2] = 3;

  return values;
} 

````

## For Loops

Sometimes we can use a *for* loop to build the contents of an array in a function rather than simply saving that array to storage

````

function getEvens() pure external returns(uint[] memory) {
  uint[] memory evens = new uint[](5);
  // Keep track of the index in the new array:
  uint counter = 0;
  // Iterate 1 through 10 with a for loop:
  for (uint i = 1; i <= 10; i++) {
    // If `i` is even...
    if (i % 2 == 0) {
      // Add it to our array
      evens[counter] = i;
      // Increment counter to the next empty index in `evens`:
      counter++;
    }
  }
  return evens;
}

````
This function will return an array with the contents [2, 4, 6, 8, 10].

## Payable

Special type of function that can receive Ether.

````

contract OnlineStore {
  function buySomething() external payable {
    // Check to make sure 0.001 ether was sent to the function call:
    require(msg.value == 0.001 ether);
    // If so, some logic to transfer the digital item to the caller of the function:
    transferThing(msg.sender);
  }
}

````
````
OnlineStore.buySomething({from: web3.eth.defaultAccount, value: web3.utils.toWei(0.001)})
````
Notice the value field, where the javascript function call specifies how much ether to send (0.001). If you think of the transaction like an envelope, and the parameters you send to the function call are the contents of the letter you put inside, then adding a value is like putting cash inside the envelope — the letter and the money get delivered together to the recipient.

## withdraw

````

contract GetPaid is Ownable {
  function withdraw() external onlyOwner {
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  }
}

````

It is important to note that you cannot transfer Ether to an address unless that address is of type address payable. But the _owner variable is of type uint160, meaning that we must explicitly cast it to address payable.



````

uint itemFee = 0.001 ether;
msg.sender.transfer(msg.value - itemFee);

````
You can use transfer to send funds to any Ethereum address. For example, you could have a function that transfers Ether back to the msg.sender if they overpaid for an item:

Or in a contract with a buyer and a seller, you could save the seller's address in storage, then when someone purchases his item, transfer him the fee paid by the buyer: seller.transfer(msg.value).

## Random number generation via keccak256

check how to generate random number on solidity doc 

## Else statement

````

if (zombieCoins[msg.sender] > 100000000) {
  // You rich!!!
} else {
  // We require more ZombieCoins...
}

````