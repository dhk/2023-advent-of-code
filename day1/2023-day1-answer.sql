/* notes
1. duckdb allows me to read directly from remote files. I'd previously put that code on my github repo
2. because this is acting directly on external data, I hardened code in a couple of places
  - use `try_cast` to avoid exceptions
  - coerce any nulls to 0 - in the case where an input line has no characters in it

  assumptions:
  1. all strings are lower case

  considerations
  1. I use CTEs throughout, so I can test and build on each step
  2. I show the working a step at a time, for ease of review - clear, not clever
  3. string manipulation is notoriously expensive - the `left/right` operators as examples here. However, since I'm solving this in SQL, I'm choosing to use an expensive compute language here.
  */

WITH source_data AS (
    SELECT *
    FROM read_csv(
        'https://raw.githubusercontent.com/dhk/2023-advent-of-code/main/day1/aoc2023.input',
        header = false,
        columns = {'col1': 'varchar'}
    )
),
step1 AS (
    SELECT
        col1,
        regexp_replace(col1, '[a-z]', '', 'g') AS num_only
    FROM source_data
),
step2 AS (
    SELECT
        col1,
        LEFT(num_only, 1) || RIGHT(num_only, 1) AS col2
    FROM step1
),
step3 AS (
    SELECT
        col1,
        IFNULL(TRY_CAST(col2 AS INT), 0) AS col2
    FROM step2
)
SELECT
    SUM(col2) AS day1_result
FROM step3;
/*
┌─────────────┐
│ day1_result │
│   int128    │
├─────────────┤
│       55208 │
└─────────────┘
*/