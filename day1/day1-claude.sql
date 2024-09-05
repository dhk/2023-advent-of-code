/* 2023 aoc day 1: claude.ai's attempt */

-- Create a table to store the input data
CREATE TEMP TABLE aoc2023_d1_document (
    line_id INT PRIMARY KEY,
    line_text VARCHAR(255)
);

-- Insert the example data
INSERT INTO aoc2023_d1_document (line_id, line_text) VALUES
(1, '1abc2'),
(2, 'pqr3stu8vwx'),
(3, 'a1b2c3d4e5f'),
(4, 'treb7uchet');

-- Extract the first and last digits, combine them, and calculate the sum
WITH extracted_digits AS (
    SELECT
        line_id,
        SUBSTRING(line_text FROM '[0-9]') AS first_digit,
        SUBSTRING(REVERSE(line_text) FROM '[0-9]') AS last_digit
    FROM aoc2023_d1_document
),
calibration_values AS (
    SELECT
        line_id,
        (first_digit || last_digit)::INT AS calibration_value
    FROM extracted_digits
)
SELECT SUM(calibration_value) AS total_calibration_value
FROM calibration_values;

/*
 total_calibration_value
-------------------------
                     142
*/