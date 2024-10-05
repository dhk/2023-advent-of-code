import argparse

# Map of spelled-out digits to numerical digits
digit_map = {
    'one': '1', 'two': '2', 'three': '3', 'four': '4', 'five': '5',
    'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'
}

# Helper function to extract digits (now case-insensitive)
def extract_digits(line):
    found_digits = []
    i = 0
    line = line.lower()  # Make the line lowercase for case-insensitive matching
    
    while i < len(line):
        # Check for numerical digit
        if line[i].isdigit():
            found_digits.append(line[i])
            i += 1
        else:
            # Check for spelled-out digits
            for word, digit in digit_map.items():
                if line[i:i+len(word)] == word:
                    found_digits.append(digit)
                    i += len(word)
                    break
            else:
                i += 1
    
    if found_digits:
        # Return the concatenation of the first and last digit found
        return int(found_digits[0] + found_digits[-1])
    else:
        # If no digits are found, return 0
        return 0

# Main function to read the input file and calculate the sum
def main():
    # Parse the command-line argument for the input file
    parser = argparse.ArgumentParser(description="Advent of Code Day 2")
    parser.add_argument('input_file', help="The input file containing the strings")
    args = parser.parse_args()

    # Open and read the input file
    with open(args.input_file, 'r') as file:
        lines = file.readlines()

    # Calculate the sum of all two-digit numbers
    total_sum = sum(extract_digits(line.strip()) for line in lines)

    # Print the final result
    print("Total sum of calibration values:", total_sum)

if __name__ == "__main__":
    main()
