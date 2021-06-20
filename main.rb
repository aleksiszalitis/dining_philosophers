# frozen_string_literal: true

# Solution to the problem is based on: https://github.com/mtking2/dining-philosophers

require_relative 'fork'
require_relative 'philosopher'

PHILOSOPHER_COUNT = 5
NAMES = %w[Alice Bob Chalire Dennis Edgars].freeze

class Main
  attr_reader :philosophers, :forks

  def initialize
    @forks = Array.new(PHILOSOPHER_COUNT) { Fork.new }
    @philosophers = []
    PHILOSOPHER_COUNT.times do |i|
      Philosopher.new(name: NAMES[i], left_fork: forks[i], right_fork: forks[(i + 1) % PHILOSOPHER_COUNT])
                 .then { |philosopher| philosophers.append(philosopher) }
    end
  end

  def run
    philosophers.each(&:join)
  end

  def finish
    philosophers.each(&:exit)
  end
end
