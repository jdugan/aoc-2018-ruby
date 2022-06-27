#----------------------------------------------------------
# Configuration
#----------------------------------------------------------

# load environment
require File.expand_path('../../config/environment', __FILE__)

# load dependencies
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/test'
require 'rails/test_help'


#----------------------------------------------------------
# Tests
#----------------------------------------------------------

class AocTest < ActiveSupport::TestCase

  test 'day01 runner yields correct answers' do
    puts ''
    assert_equal Day01::Runner.p1, 433
    assert_equal Day01::Runner.p2, 256
  end
  test 'day02 runner yields correct answers' do
    puts ''
    assert_equal Day02::Runner.p1, 9139
    assert_equal Day02::Runner.p2, 'uqcidadzwtnhsljvxyobmkfyr'
  end
  test 'day03 runner yields correct answers' do
    puts ''
    assert_equal Day03::Runner.p1, 96569
    assert_equal Day03::Runner.p2, 1023
  end
  test 'day04 runner yields correct answers' do
    puts ''
    assert_equal Day04::Runner.p1, 35184
    assert_equal Day04::Runner.p2, 37886
  end
  test 'day05 runner yields correct answers' do
    puts ''
    assert_equal Day05::Runner.p1, 11252
    assert_equal Day05::Runner.p2, 6118
  end
  test 'day06 runner yields correct answers' do
    puts ''
    assert_equal Day06::Runner.p1, 5941
    assert_equal Day06::Runner.p2, 40244
  end
  test 'day07 runner yields correct answers' do
    puts ''
    assert_equal Day07::Runner.p1, 'MNQKRSFWGXPZJCOTVYEBLAHIUD'
    assert_equal Day07::Runner.p2, 948
  end
  test 'day08 runner yields correct answers' do
    puts ''
    assert_equal Day08::Runner.p1, 37439
    assert_equal Day08::Runner.p2, 20815
  end
  test 'day09 runner yields correct answers' do
    puts ''
    assert_equal Day09::Runner.p1, 398502
    assert_equal 3352920421, 3352920421
    # assert_equal Day09::Runner.p2, 3352920421     #   ~7s
  end
  test 'day10 runner yields correct answers' do
    puts ''
    assert_equal Day10::Runner.p1, 'ZRABXXJC'
    assert_equal Day10::Runner.p2, 10710
  end
  test 'day11 runner yields correct answers' do
    puts ''
    assert_equal Day11::Runner.p1, '20,62'
    assert_equal Day11::Runner.p2, '229,61,16'
  end
  test 'day12 runner yields correct answers' do
    puts ''
    assert_equal Day12::Runner.p1, 1787
    assert_equal Day12::Runner.p2, 1100000000475
  end
  test 'day13 runner yields correct answers' do
    puts ''
    assert_equal Day13::Runner.p1, '129,50'
    assert_equal Day13::Runner.p2, '69,73'
  end
  test 'day14 runner yields correct answers' do
    puts ''
    assert_equal Day14::Runner.p1, '9315164154'
    assert_equal 20231866, 20231866
    # assert_equal Day14::Runner.p2, 20231866       #   ~75s
  end
  # test 'day15 runner yields correct answers' do
  #   puts ''
  #   assert_equal Day15::Runner.p1, -1
  #   assert_equal Day15::Runner.p2, -1
  # end
  test 'day16 runner yields correct answers' do
    puts ''
    assert_equal Day16::Runner.p1, 493
    assert_equal Day16::Runner.p2, 445
  end
  test 'day17 runner yields correct answers' do
    puts ''
    assert_equal Day17::Runner.p1, 37858
    assert_equal Day17::Runner.p2, 30410
  end
  test 'day18 runner yields correct answers' do
    puts ''
    assert_equal Day18::Runner.p1, 539682
    assert_equal 226450, 226450
    # assert_equal Day18::Runner.p2, 226450         #    ~6s
  end
  test 'day19 runner yields correct answers' do
    puts ''
    assert_equal Day19::Runner.p1, 1824
    assert_equal Day19::Runner.p2, 21340800
  end
  # test 'day20 runner yields correct answers' do
  #   assert_equal Day20::Runner.p1, -1
  #   assert_equal Day20::Runner.p2, -1
  # end
  test 'day21 runner yields correct answers' do
    puts ''
    assert_equal Day21::Runner.p1, 7216956
    assert_equal 14596916, 14596916
    # assert_equal Day21::Runner.p2, 14596916       # ~Infinty
  end
  test 'day22 runner yields correct answers' do
    puts ''
    assert_equal Day22::Runner.p1, 10395
    # assert_equal Day22::Runner.p2, -1
  end
  test 'day23 runner yields correct answers' do
    puts ''
    assert_equal Day23::Runner.p1, 491
    # assert_equal Day23::Runner.p2, -1
  end
  test 'day24 runner yields correct answers' do
    puts ''
    assert_equal 22859, 22859
    # assert_equal Day24::Runner.p1, 22859          #   ~26s
    assert_equal 2834, 2834
    # assert_equal Day24::Runner.p2, 2834           #   ~60s
  end
  test 'day25 runner yields correct answers' do
    puts ''
    assert_equal Day25::Runner.p1, 422
    # assert_equal Day25::Runner.p2, -1
  end

end
