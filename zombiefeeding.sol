pragma solidity >=0.5.0 <0.6.0;

//import 
import "./zombiefactory.sol";

// Inheritance
contract ZombieFeeding is ZombieFactory {
    
    //feedAndMultiply function with 2 parameters
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {

        //Make sure we own the zombie by verifie that msg.sender is equal to this zombie's owner and only us can feed him
        require (msg.sender == zombieToOwner[_zombieId]);

        //Need to get ths zombie's DNA so we have to declare a local Zombie named _myZombie this variable will be equal the index _zombieId
        Zombie storage myZombie = zombies[_zombieId];

        //_targetDna isn't longer than 16 digits. Here we only take the last 16 digits
        _targetDna = _targetDna % dnaModulus;

        //Declare a uint named newDna and we set it equal to the average of myZombie DNA and _targetDna
        uint newDna = (myZombie.dna + _targetDna) / 2;

        //When we have the new DNA, we call _createZombie. It require a Name but we set it first to NoName, we will create a function to change the zombie's name after
        _createZombie("NoName", newDna);
    }
}
 