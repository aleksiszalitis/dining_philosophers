# frozen_string_literal: true

class Philosopher < Thread
  attr_accessor :name, :left_fork, :right_fork

  def initialize(name:, left_fork:, right_fork:)
    @name = name
    @left_fork = left_fork
    @right_fork = right_fork
    super { start }
  end

  def start
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
