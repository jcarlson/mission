require_relative 'grid'
require_relative 'rover'

class CommandLoop
  attr_reader :grid, :rovers
  attr_accessor :active_rover

  GRID = /^(?<width>\d+)\s(?<height>\d+)$/
  ROVER_POSITION = /^(?<x>\d+)\s(?<y>\d+)\s(?<bearing>[NSEW])$/
  ROVER_COMMANDS = /^(?<commands>[LRM]+)$/

  def self.main
    command_loop = new

    loop do
      input = gets.chomp
      break if input == ''
      command_loop.process_input(input)
    end

    command_loop.print_results
  end

  def initialize
    @rovers = []
  end

  def process_input(input)
    case
    when match = GRID.match(input)
      raise ArgumentError unless grid.nil?
      initialize_grid(match)
    when match = ROVER_POSITION.match(input)
      raise ArgumentError unless active_rover.nil?
      initialize_rover(match)
    when match = ROVER_COMMANDS.match(input)
      raise ArgumentError if grid.nil? || active_rover.nil?
      command_rover(match)
      self.active_rover = nil
    else
      raise ArgumentError
    end
  end

  def print_results
    rovers.each { |rover| puts rover.position }
  end

  private

  def initialize_grid(grid_input)
    @grid = Grid.new(grid_input[:width], grid_input[:height])
  end

  def initialize_rover(position_input)
    self.active_rover = Rover.new(grid, position_input[:x], position_input[:y], position_input[:bearing])
    rovers << active_rover
  end

  def command_rover(command_input)
    command_input[:commands].chars.each do |command|
      case command
      when 'L'
        active_rover.rotate_left
      when 'R'
        active_rover.rotate_right
      else
        active_rover.move_forward
      end
    end
  end
end
