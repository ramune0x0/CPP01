#include "Zombie.hpp"

Zombie* zombieHorde(int N, std::string name);

int main()
{
    int N = 5;
    Zombie* horde = zombieHorde(N, "42Zombie");

    for (int i = 0; i < N; ++i)
        horde[i].announce();

    delete[] horde;
}
