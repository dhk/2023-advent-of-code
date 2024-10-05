import pandas as pd
import re
import sys

def extract_calibration_value(line):
    digits = re.findall(r'\d', line)
    if not digits:
        return 0
    return int(digits[0] + digits[-1])

def process_calibration_document(file_path):
    try:
        # Read the file
        with open(file_path, 'r') as file:
            data = file.read().splitlines()

        # Create a DataFrame
        df = pd.DataFrame(data, columns=['calibration_string'])

        # Apply the extraction function
        df['calibration_value'] = df['calibration_string'].apply(extract_calibration_value)

        # Calculate the sum
        total_sum = df['calibration_value'].sum()

        return total_sum

    except FileNotFoundError:
        print(f"Error: The file {file_path} was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script_name.py <path_to_input_file>")
        sys.exit(1)

    file_path = sys.argv[1]
    result = process_calibration_document(file_path)
    if result is not None:
        print(f"The sum of all calibration values is: {result}")