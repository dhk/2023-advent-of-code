-- ok. here's how I did it
select * from '2023-day1.csv'; -- check the data. looks good
-- now, persist it
create table d2023_day1 as select * from '2023-day1.csv';
-- let's start futzing with the regex
select col1, regexp_replace(col1, '[a-z]', '') from d2023_day1;
 -- kind of ok; but look how it doesn't get all the characters...
 /*
┌─────────────┬───────────────────────────────────┐
│    col1     │ regexp_replace(col1, '[a-z]', '') │
│   varchar   │              varchar              │
├─────────────┼───────────────────────────────────┤
│ 1abc2       │ 1bc2                              │
│ pqr3stu8vwx │ qr3stu8vwx                        │
│ a1b2c3d4e5f │ 1b2c3d4e5f                        │
│ treb7uchet  │ reb7uchet                         │
└─────────────┴───────────────────────────────────┘
*/
-- ah 'g' flag
D select col1, regexp_replace(col1, '[a-z]', '', 'g') from d2023_day1;
/*
┌─────────────┬────────────────────────────────────────┐
│    col1     │ regexp_replace(col1, '[a-z]', '', 'g') │
│   varchar   │                varchar                 │
├─────────────┼────────────────────────────────────────┤
│ 1abc2       │ 12                                     │
│ pqr3stu8vwx │ 38                                     │
│ a1b2c3d4e5f │ 12345                                  │
│ treb7uchet  │ 7                                      │
└─────────────┴────────────────────────────────────────┘
*/

/* ok. so now we're most of the way there. i'll turn it into a CTE to make life easier
things to pay attention to
* take the first and last digits. I'll take the left-most and right-most characters
*/
with step1 as (select col1, regexp_replace(col1, '[a-z]', '', 'g') num_only from d2023_day1)
  select * from step1;
  /*
┌─────────────┬──────────┐
│    col1     │ num_only │
│   varchar   │ varchar  │
├─────────────┼──────────┤
│ 1abc2       │ 12       │
│ pqr3stu8vwx │ 38       │
│ a1b2c3d4e5f │ 12345    │
│ treb7uchet  │ 7        │
└─────────────┴──────────┘
*/
with step1 as (select col1, regexp_replace(col1, '[a-z]', '', 'g') num_only from d2023_day1)
  select col1, left(num_only, 1) || right(num_only, 1) col2 from step1;
/*
┌─────────────┬─────────┐
│    col1     │  col2   │
│   varchar   │ varchar │
├─────────────┼─────────┤
│ 1abc2       │ 12      │
│ pqr3stu8vwx │ 38      │
│ a1b2c3d4e5f │ 15      │
│ treb7uchet  │ 77      │
└─────────────┴─────────┘
*/
-- this is doing the right thing. Now, convert to integer and sum
with step1 as (select col1, regexp_replace(col1, '[a-z]', '', 'g') num_only from d2023_day1)
  , step2 as (select col1, left(num_only, 1) || right(num_only, 1) col2 from step1)
  select sum(cast(col2 as int)) day_1_result  from step2;
/*
┌──────────────┐
│ day_1_result │
│    int128    │
├──────────────┤
│          142 │
└──────────────┘
*/

/* however, this code is brittle
1. it assumes that the cast will always fail
2. it doesn't account for the possible presence of nulls. that can happen if there's no numbers in the input string.
*/
-- here's a more pessimistic/code-safe example:
with step1 as (select col1, regexp_replace(col1, '[a-z]', '', 'g') num_only from d2023_day1)
    , step2 as (select col1, left(num_only, 1) || right(num_only, 1) col2 from step1)
  , step3 as (select col1, ifnull(try_cast(col2 as int), 0) col2 from step2)
  select * from step3;
  /*
┌─────────────┬───────┐
│    col1     │ col2  │
│   varchar   │ int32 │
├─────────────┼───────┤
│ 1abc2       │    12 │
│ pqr3stu8vwx │    38 │
│ a1b2c3d4e5f │    15 │
│ treb7uchet  │    77 │
└─────────────┴───────┘
*/
-- and the result:
with step1 as (select col1, regexp_replace(col1, '[a-z]', '', 'g') num_only from d2023_day1)
      , step2 as (select col1, left(num_only, 1) || right(num_only, 1) col2 from step1)
    , step3 as (select col1, ifnull(try_cast(col2 as int), 0) col2 from step2)
  select sum(col2) as day1_calibration from step3;
/*
┌──────────────────┐
│ day1_calibration │
│      int128      │
├──────────────────┤
│              142 │
└──────────────────┘
*/
-- So, our code checks out
-- let's run it on the full set.
-- the file is hosted here, and duckdb makes it easy to see the data
-- https://raw.githubusercontent.com/dhk/2023-advent-of-code/main/day1/aoc2023.input
select count(*)  from read_csv('https://raw.githubusercontent.com/dhk/2023-advent-of-code/main/day1/aoc2023.input', header=false, columns = {'col1': 'varchar'});
/*
1,000 rows - that's correct
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│         1000 │
└──────────────┘
 */
 -- so let me go ahead and instantiate it


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