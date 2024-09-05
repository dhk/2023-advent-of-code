/* chatgpt solves day 1 */
CREATE temp TABLE calibration_data (
    line_text TEXT
);

INSERT INTO calibration_data (line_text) VALUES
('1abc2'),
('pqr3stu8vwx'),
('a1b2c3d4e5f'),
('treb7uchet');

SELECT SUM(CAST(
  LEFT(regexp_replace(line_text, '[^0-9]', '', 'g'), 1) ||
  RIGHT(regexp_replace(line_text, '[^0-9]', '', 'g'), 1) AS INTEGER)
) AS total_sum
FROM calibration_data;
/*
 total_sum
-----------
       142
*/
