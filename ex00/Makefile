NAME = ex00

CXX = c++
CXXFLAGS = -Wall -Wextra -Werror -pedantic -std=c++98 -Iinc

SRC_DIR = src
OBJ_DIR = obj
INC_DIR = inc

SRC_FILES = main.cpp \
			Zombie.cpp \
			newZombie.cpp \
			randomChump.cpp

OBJ_FILES = $(SRC_FILES:%.cpp=$(OBJ_DIR)/%.o)

all: $(NAME)

$(NAME): $(OBJ_FILES)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
