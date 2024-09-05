# 2023-advent of code day 1

[Problem statement](https://adventofcode.com/2023/day/1)

I'm using duckDB throughout

# Results
* [Day 1 verified result in SQL](2023-day1-answer.sql)
* [Day 1 Scratchpad](2023-day1-working.sql)

## AI Attempts
* Both ChatGPT & Claude.ai got it right on the first attempt, without coercion (aka "prompt engineering")
* They took a better approach than me - they selected *for* numerics in their `regex` whereas I stripped out alphabetics. Better solution
* ChatGPT used left/right string operators (like me), which is tidier
* Claude used `reverse` which is less clear

---
# what's notable
DuckDB makes it easy for me to do serverless computing -- I'm computing directly against the source files without having to deal with database loads.

Here's the relevant code
```
    SELECT *
    FROM read_csv(
        'https://raw.githubusercontent.com/dhk/2023-advent-of-code/main/day1/aoc2023.input',
        header = false,
        columns = {'col1': 'varchar'}
```
