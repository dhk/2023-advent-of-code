# attempt #2 is correct
import re

# List of input lines
lines = [
    "1abc2",
    "pqr3stu8vwx",
    "a1b2c3d4e5f",
    "treb7uchet"
]

# Initialize the total sum
total_sum = 0

# Iterate through each line
for line in lines:
    # Find all digits in the line
    digits = re.findall(r'\d', line)

    # Ensure there are at least two digits to form a valid calibration value
    if len(digits) >= 2:
        # Combine the first and last digit as a two-digit number
        calibration_value = int(digits[0] + digits[-1])
        total_sum += calibration_value
    elif len(digits) == 1:
        # If there's only one digit, treat it as both first and last (e.g., 77)
        calibration_value = int(digits[0] + digits[0])
        total_sum += calibration_value
    else:
        print(f"Line '{line}' does not have any digits.")

# Print the total sum of calibration values
print("Total sum of calibration values:", total_sum)

# Output: Total sum of calibration values: 142