# frozen_string_literal: true

PHILOSOPHER_COUNT = 5

NAMES = %w(Alice Bob Chalire Dennis Edgars)

class Philosopher < Thread
  attr_accessor :name, :left_fork, :right_fork

  def initialize(name, left_fork, right_fork)
    @name = name
    @left_fork = left_fork
    @right_fork = right_fork
    super { run }
  end

  def run
    loop do
      think
      eat
    end
  end

  private

  def think
    puts "#{name} is thinking"
    sleep(rand)
  end

  def eat
    left_fork.lock
    right_fork.lock
    eat_noodles
    left_fork.unlock
    right_fork.unlock
  end

  def eat_noodles
    puts "#{name} is eating noodels"
    sleep(rand)
  end
end

class Fork < Mutex; end

def main
  forks = Array.new(PHILOSOPHER_COUNT) { Fork.new }
  philosophers = []
  PHILOSOPHER_COUNT.times do |i|
    Philosopher.new(NAMES[i], forks[i], forks[(i + 1) % PHILOSOPHER_COUNT])
      .then { |philosopher| philosophers.append(philosopher) }
  end
  philosophers.each(&:join)
end
