#include <fstream>
#include <iostream>
#include <iterator>
#include <string>

static void printUsage(const char *progName)
{
    std::cerr << "Usage: " << progName << " <filename> <s1> <s2>" << std::endl;
}

static int printError(const std::string &msg)
{
    std::cerr << "Error: " << msg << std::endl;
    return 1;
}

static std::string readAll(std::ifstream &ifs)
{
    return std::string(
        std::istreambuf_iterator<char>(ifs),
        std::istreambuf_iterator<char>());
}

static std::string replaceAll(const std::string &text,
                              const std::string &from,
                              const std::string &to)
{
    std::string result;
    result.reserve(text.size());

    std::string::size_type last = 0;
    std::string::size_type pos = 0;

    while ((pos = text.find(from, last)) != std::string::npos)
    {
        result.append(text, last, pos - last);
        result += to;
        last = pos + from.size();
    }
    result.append(text, last, std::string::npos);
    return result;
}

int main(int ac, char **av)
{
    if (ac != 4)
    {
        printUsage(av[0]);
        return 1;
    }

    const std::string filename(av[1]);
    const std::string from(av[2]);
    const std::string to(av[3]);

    if (from.empty())
    {
        return printError("s1 must not be empty");
    }

    // open input file
    std::ifstream ifs(filename.c_str());
    if (!ifs)
    {
        return printError(std::string("cannot open input file: ") + filename);
    }

    // read whole file, replace, then write to "<filename>.replace"
    const std::string text = readAll(ifs);
    const std::string replaced = replaceAll(text, from, to);

    const std::string outName = filename + ".replace";
    std::ofstream ofs(outName.c_str());
    if (!ofs)
    {
        return printError(std::string("cannot create output file: ") + outName);
    }

    ofs << replaced;
    if (!ofs)
    {
        return printError(std::string("write failed: ") + outName);
    }
    return 0;
}
