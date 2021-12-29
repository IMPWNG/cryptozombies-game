pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // the event called NewZombie with zombieId, name, dna parameters 
    event NewZombie(uint zombieId, string name, uint dna);

    // dnaDigits is equal to 16
    uint dnaDigits = 16;

    // dnaModulus is equal to 10 to the power of dnaDigits
    uint dnaModulus = 10 ** dnaDigits;

    // struct named Zombie with 2 properties (name as a string and dna as a uint)
    struct Zombie {
        string name;
        uint dna;
    }

    // public array of zombie struct, named zombies
    Zombie[] public zombies;

    // uint key to store and look up the wombie based on its id and the value an address
    mapping (uint => address) public zombieToOwner;

    // key is an address and value a uint for keeping track oh how many zombies an owner has
    mapping (address => uint) ownerZombieCount;

    // interal (for inherite accessibility) function named _createZombie with the first argument by value using memory
    function _createZombie(string memory _name, uint _dna) interal {

        // Here we need the zombie's id. array.push() return the new lenght of the arrayand since the first item in an array has index 0, array.push() - 1 will be the index of the zombie we just added. Store the result of zombies.push() - 1 in a uint called id, so you can use this in the NewZombie event in the next line.
        uint id = zombies.push(Zombie(_name, _dna)) - 1;

        // after new zombieId we update our zombietoOwner mapping to store msg.sender under that id
        zombieToOwner[id] = msg.sender;

        // we increase the ownerZombieCount for this msg.sender
        ownerZombieCount[msg.sender]++;

        // fire the NewZombie after adding the new zombie to our zombies array
        emit NewZombie(id, _name, _dna);
    }

    // Private function named _generateRandomDna with one paramater _str sotred in memory wich is returned a uint and we can only view the data inside
    function _generateRandomDna(string memory _str) private view returns (uint) {

        // we take the keccak256 hash of the abi.encodePacked(_str) to generate a pseudo-randome hexa typecast with a uint and we store the resul in a uint called rand
        uint rand = uint(keccak256(abi.encodePacked(_str)));

        // Here, we want our DNA to only be 16 digits long so we return the modulus %dnaModulus
        return rand % dnaModulus;
    }
    
    // public function named createRandomZombie with one parameter stored to memory
    function createRandomZombie(string memory _name) public {

        //the createRandomZombie function  only get executed one time per user, when they create their first zombie. The ownerZombieCount[msg.sender] is equal to 0 otherwise throw and error
        require (ownerZombieCount[msg.sender] == 0;)

        // Here we run the _generateRandomDna function on _name and we stor it in a uint named randDna
        uint randDna = _generateRandomDna(_name);

        // Here we run _createZombie and we pass it _name and randDna
        _createZombie(_name, randDna);
    }

}

