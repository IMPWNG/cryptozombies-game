pragma solidity >=0.5.0 <0.6.0;

//import 
import "./zombiefactory.sol";

// Here we capture the data
contract KittyInterface     {
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

// Here we have access to the zombieFactory function set as public
contract ZombieFeeding is ZombieFactory {

    // We declare the variable *kittyContract* with *KittyInterface*
    KittyInterface kittyContract;

    // This function 
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    //feedAndMultiply function with 3 parameters
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {

        //Make sure we own the zombie by verifie that msg.sender is equal to this zombie's owner and only us can feed him
        require (msg.sender == zombieToOwner[_zombieId]);

        //Need to get ths zombie's DNA so we have to declare a local Zombie named _myZombie this variable will be equal the index _zombieId
        Zombie storage myZombie = zombies[_zombieId];

        //_targetDna isn't longer than 16 digits. Here we only take the last 16 digits
        _targetDna = _targetDna % dnaModulus;

        //Declare a uint named newDna and we set it equal to the average of myZombie DNA and _targetDna
        uint newDna = (myZombie.dna + _targetDna) / 2;

        // after we calculate the new zombie DNA above we compare the keccak256 of _species and the string kitty
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {

            //now we replace the last 2 digits of DNA with 99. "Assume newDna is 334455. Then newDna % 100 is 55, so newDna - newDna % 100 is 334400. Finally add 99 to get 334499."
            newDna = newDna - newDna % 100 + 99;
        }

        //When we have the new DNA, we call _createZombie. It require a Name but we set it first to NoName, we will create a function to change the zombie's name after
        _createZombie("NoName", newDna);
    }

    // The function feedOnKitty has _zombieId and _kittyId as parameters
    function feedOnKitty(uint _zombiId, uint _kittyId) public {

        // we first declare a uint named KittyDna (genes from the function getKitty above)
        uint kittyDna;

        // then, we call the kittyContract.getKitty function with _kittyId and we store genes in KittyDna. getKitty return a bunch of variables but we only care about the 10 ones, genes
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);

        // then we call the function feedAndMultiply and we pass it _zombieId, kittyDna and kitty.
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
 