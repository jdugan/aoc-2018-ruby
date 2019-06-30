# 2018 Advent of Code (Ruby)

This repository implements solutions to all 50 puzzles in the [2018 Advent of Code](https://adventofcode.com/2018/about) using Ruby.


## Preface

I've organised everything inside a Rails project to make the Rails console available for running the solutions.  Rails itself is not required to solve any puzzle.

The solutions are organised predominantly for comprehension. They strive to arrive at an answer in a reasonable period of time, but they typically prioritise optimal understanding over optimal performance.

The examples are representative of my thinking and coding style.


## Getting Started

### Prerequisites

The project requires `ruby 2.6.3`, though any reasonably current version of Ruby will likely work.

If you use a ruby manager that responds to `.tool-versions` or `ruby-version`, you should be switched to `2.6.3` automatically.


### Installation

The project installs like any simple Rails application.

```
$ git clone https://github.com/jdugan/advent-2018-ruby.git
$ cd advent-2018-ruby
$ bundle install
$ cp .env.example .env
```

The project uses the gem `dotenv-rails` to autoload one environment variable `AOC_MODE`.  This variable accepts two values: `prod` and `test`.  Runners use the mode to determine which input file to read.  

Mode switching is only broadly useful when composing solutions. By default, the project runs against my actual puzzle input (i.e., `prod` mode) in deference to reviewers.

### File Structure

The solutions are organized in `dayNN` folders in the `app/models` directory.

Each day contains:

```
data
  prod.txt      # my puzzle input
  test.txt      # sample input from the README
helpers
  *.rb          # whatever structs I used to model data
  *.rb
README.md       # puzzle description from AoC (plus my answers)
runner.rb       # concrete implementation of the abstract runner
```

*Strictly speaking, none of the files are models, but placing them here causes Rails to autoload them in the console, which is nice.*

### Running Examples

Runners have three public methods: `p1` runs the solution to the first puzzle; `p2` runs the solution to the second puzzle; `both` runs both solutions.

For example, to run the complete--and super fun--solution for Day10:

```
$ bundle exec rails console
irb(main)> Day10::Runner.both
```
