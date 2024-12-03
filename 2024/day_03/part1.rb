# frozen_string_literal: true

pp File.read('input.txt').scan(/mul\(\d*,\d*\)/).map { |d| d.delete('mul()').split(',').map(&:to_i).inject(:*) }.sum
