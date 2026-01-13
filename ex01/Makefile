NAME = ex01

CXX = c++
CXXFLAGS = -Wall -Wextra -Werror -pedantic -std=c++98 -Iinc

SRC_DIR = src
OBJ_DIR = obj
INC_DIR = inc

SRC_FILES = main.cpp \
            Zombie.cpp \
            zombieHorde.cpp

OBJ_FILES = $(SRC_FILES:%.cpp=$(OBJ_DIR)/%.o)

all: $(NAME)

# Link object files
$(NAME): $(OBJ_FILES)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Compile .cpp to .o inside obj/
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re