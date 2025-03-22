require "minitest/autorun"

class Day1
  attr_reader :left_side, :right_side, :right_with_count, :file_path

  def initialize(file_path)
    @left_side = []
    @right_side = []
    @right_with_count = Hash.new(0)
    @file_path = file_path
  end

  def parse
    File.foreach(file_path) do |line|
      split_line = line.split
      left = split_line[0].to_i
      right = split_line[1].to_i
      right_with_count[right] += 1
      @left_side << left
      @right_side << right
    end
  end

  def check_part_one
    sum = 0
    sorted_left = left_side.sort
    sorted_right = right_side.sort

    sorted_left.each_with_index do |left, i|
      right = sorted_right[i]
      sum += (left - right).abs
    end

    sum
  end

  def check_part_two
    similarity = 0

    left_side.each do |left|
      right_count = right_with_count[left] || 0
      similarity += left * right_count
    end

    similarity
  end
end

day1 = Day1.new(__dir__ + "/input.dat")
day1.parse

puts "Part One:"
puts day1.check_part_one
puts
puts "Part Two:"
puts day1.check_part_two
puts

class Day1Tests < Minitest::Test
  def test_part_one
    day1 = Day1.new(__dir__ + "/test_input.dat")
    day1.parse
    assert_equal 11, day1.check_part_one
  end

  def test_part_two
    day1 = Day1.new(__dir__ + "/test_input.dat")
    day1.parse
    assert_equal 31, day1.check_part_two
  end
end
