CXX = c++
CXXFLAGS = -Wall -Wextra -Werror -std=c++98

NAME = ex01

SRCS = main.cpp \
	   Zombie.cpp \
	   zombieHorde.cpp 
OBJ_DIR = obj
OBJS = $(SRCS:%.cpp=$(OBJ_DIR)/%.o)

# Default rule
all: $(OBJ_DIR) $(NAME)

# Create obj/ directory if it doesn't exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# Link object files
$(NAME): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(NAME) $(OBJS)

# Compile .cpp to .o inside obj/
$(OBJ_DIR)/%.o: %.cpp Zombie.hpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean object files
clean:
	rm -rf $(OBJ_DIR)

# Clean object files and executable
fclean: clean
	rm -f $(NAME)

# Rebuild everything
re: fclean all

.PHONY: all clean fclean re