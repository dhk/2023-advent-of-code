# 2023-advent of code day 1

[Problem statement](https://adventofcode.com/2023/day/1)

I'm using duckDB throughout

# Results
* [Day 1 verified result in SQL](2023-day1-answer.sql)
* [Day 1 Scratchpad](2023-day1-working.sql)

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
