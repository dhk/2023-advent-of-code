# Map of spelled-out digits to numerical digits
digit_map = {
    'one': '1', 'two': '2', 'three': '3', 'four': '4', 'five': '5',
    'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'
}

# Helper function to extract digits
def extract_digits(line):
    found_digits = []
    i = 0
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
        # Return the concatenation of the first and last digit
        return int(found_digits[0] + found_digits[-1])
    else:
        # If no digits are found, return 0 or some default
        return 0

# Input data (replace with actual input)
lines = [
    "two1nine",
    "eightwothree",
    "abcone2threexyz",
    "xtwone3four",
    "4nineeightseven2",
    "zoneight234",
    "7pqrstsixteen"
]

# Calculate the sum of all two-digit numbers
total_sum = sum(extract_digits(line) for line in lines)

print("Total sum of calibration values:", total_sum)
