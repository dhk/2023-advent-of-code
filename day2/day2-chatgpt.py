import pandas as pd

# Manually reading the file line-by-line to extract the game lines
#file_path = '/mnt/data/2023-day2.csv'
file_path = '2023-day2.csv' # edited for local running
with open(file_path, 'r') as file:
    raw_lines = file.readlines()

# Filtering lines that start with "Game" to get the game data
game_data_cleaned = [line.strip() for line in raw_lines if line.startswith("Game")]

# Function to parse the cleaned game data
def parse_game_data_fixed(game_data):
    games = []
    for line in game_data:
        # Extracting the game ID (e.g., "Game 4")
        game_id_str, sets_str = line.split(": ", 1)
        game_id = int(game_id_str.replace("Game ", "").replace(":", ""))

        # Splitting the sets of cubes based on semicolons
        sets = sets_str.split("; ")
        game_sets = []
        for s in sets:
            color_counts = {"red": 0, "green": 0, "blue": 0}
            cubes = s.split(", ")
            for cube in cubes:
                count, color = cube.split(" ")
                color_counts[color] = int(count)
            game_sets.append(color_counts)
        games.append((game_id, game_sets))
    return games

# Function to check if the game is possible given the limits of cubes
def is_game_possible(game_sets, limits):
    for s in game_sets:
        if s["red"] > limits["red"] or s["green"] > limits["green"] or s["blue"] > limits["blue"]:
            return False
    return True

# Function to find the sum of possible game IDs
def find_possible_games_fixed(game_data):
    games = parse_game_data_fixed(game_data)
    limits = {"red": 12, "green": 13, "blue": 14}
    possible_games_sum = 0
    for game_id, game_sets in games:
        if is_game_possible(game_sets, limits):
            possible_games_sum += game_id
    return possible_games_sum

# Running the solution to calculate the sum of possible game IDs
result = find_possible_games_fixed(game_data_cleaned)
result
