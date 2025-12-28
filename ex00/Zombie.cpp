#include "Zombie.hpp"

// Constructor
Zombie::Zombie(std::string name) : name(name){
}

// Destructor
Zombie::~Zombie(){
    std::cout << name << " is destroyed" << std::endl;
}

// Zombies announce themselves as follows:
// <name>: BraiiiiiiinnnzzzZ...

// Do not print the angle brackets (< and >). 
// For a zombie named Foo, the message would be:
// Foo: BraiiiiiiinnnzzzZ...

void Zombie::announce(void){
    std::cout << name << " : BraiiiiiiinnnzzzZ..." << std::endl;
}

