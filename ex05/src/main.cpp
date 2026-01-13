#include "Harl.hpp"

#include <iostream>

int main(int argc, char **argv) {
  Harl harl;

  if (argc == 2) {
    harl.complain(argv[1]);
    return 0;
  }

  std::cerr << "Usage: ./ex05 <LEVEL>" << std::endl;
  std::cerr << "LEVEL: DEBUG | INFO | WARNING | ERROR" << std::endl;
  return 1;
}

