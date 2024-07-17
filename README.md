# 2018 Advent of Code (Ruby)

This repository implements solutions to the puzzles in the
[2018 Advent of Code](https://adventofcode.com/2018) using Ruby.


## Preface

The solutions are organised predominantly for comprehension. They strive to arrive at an
answer in a reasonable period of time, but they typically prioritise optimal understanding
over optimal performance.

The examples are representative of my thinking and coding style.


## Getting Started

### Prerequisites

The project requires `ruby 3.3.3`, but any reasonably current version of
Ruby will likely work.  I tend to code done the middle of any language
specification.

If you use an Ruby manager that responds to `.tool-versions`, you should
be switched to correct version automatically. I recommend [ASDF](https://github.com/asdf-vm/asdf)
for those on platforms that support it.


### Installation

The project installs like any simple Rails application.

```
$ git clone https://github.com/jdugan/aoc-2018-ruby.git
$ cd aoc-2018-ruby
$ bundle install
$ bundle exec rake db:create
$ bundle exec rails s
```

Then open a browser to `http://localhost:3000`.


### Running Daily Solutions

The solutions are organized in `dayNN` folders in the `app/models` directory.

Runner classes are designed to be called from the rails console via one of
three public methods:

- `p1` runs the solution to the first puzzle;
- `p2` runs the solution to the second puzzle;
- `both` runs both solutions.

For example, to run the complete--and super fun--solution for Day10:

```
$ bundle exec rails console
> Day10::Runner.both
```

### Running Tests

The only tests are a set of checks to verify solved puzzles.

I often refactor my solutions for clarity (or as I learn new
techniques in subsequent puzzles), so it is helpful to have
these simple tests to give my refactors some confidence.

To execute the tests, simply execute the following command in
your terminal from the project root.

```
$ bundle exec test
```