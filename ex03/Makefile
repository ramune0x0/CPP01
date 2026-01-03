NAME = ex03

CXX = c++
CXXFLAGS = -Wall -Wextra -Werror -Iinc -std=c++98

SRCS = src/Weapon.cpp \
       src/HumanA.cpp \
       src/HumanB.cpp \
       src/main.cpp

OBJ_DIR = obj
OBJS = $(SRCS:src/%.cpp=$(OBJ_DIR)/src/%.o)

# Default rule
all: $(OBJS) $(NAME)

# Create obj/src/ directory if it doesn't exist
$(OBJ_DIR)/src:
	mkdir -p $(OBJ_DIR)/src

# Link object files
$(NAME): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(NAME) $(OBJS)

# Compile .cpp to .o inside obj/src/
$(OBJ_DIR)/src/%.o: src/%.cpp | $(OBJ_DIR)/src
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
