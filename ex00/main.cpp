#include "Zombie.hpp"

Zombie* newZombie(std::string name);
void randomChump(std::string name);

int main()
{
    randomChump("StackZombie");

    Zombie* z = newZombie("HeapZombie");
    z->announce();
    delete z;

    return 0;
}
