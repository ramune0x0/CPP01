#include <iostream>
#include <string>

int main()
{
    std::string str = "HI THIS IS BRAIN";

    std::string* stringPTR = &str;
    std::string& stringREF = str;

    std::cout << "Address of str:       " << &str << std::endl;
    std::cout << "Address held by PTR:  " << stringPTR << std::endl;
    std::cout << "Address held by REF:  " << &stringREF << std::endl;

    std::cout << std::endl;

    std::cout << "Value of str:        " << str << std::endl;
    std::cout << "Value pointed by PTR:" << *stringPTR << std::endl;
    std::cout << "Value pointed by REF:" << stringREF << std::endl;

    return 0;
}
