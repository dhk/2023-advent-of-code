# day 1 claude attempt: correct
def extract_calibration_value(line):
    digits = [char for char in line if char.isdigit()]
    if not digits:
        return 0
    return int(digits[0] + digits[-1])

def calculate_total_calibration_value(document):
    return sum(extract_calibration_value(line) for line in document)

# Example usage
document = [
    "1abc2",
    "pqr3stu8vwx",
    "a1b2c3d4e5f",
    "treb7uchet"
]

total = calculate_total_calibration_value(document)
print(f"The total calibration value is: {total}")

# Answer: The total calibration value is: 142