require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  include CompanyName
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :speed, :number, :wagons
  attr_accessor_with_history :current_station, :route

  NUMBER_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/i

  validate :number, :presence
  validate :number, :length
  validate :number, :format, NUMBER_FORMAT

  @@all = {}
  def self.find(number)
    @@all[number]
  end

  def initialize(number)
    @number = number
    @current_station_index = 0
    @speed = 0
    @wagons = []
    validate!
    @@all[number] = self
    register_instance
  end

  def speed_stop
    self.speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && right_type?(wagon)
  end

  def remove_wagon
    @wagons.pop if @speed.zero?
  end

  def add_route(route)
    @current_route = route
    @current_station_index = 0
    current_station.train_arrival(self)
  end

  def forward
    return unless @current_station_index != @current_route.station_list.length - 1
    current_station.train_departure(self)
    @current_station_index += 1
    current_station.train_arrival(self)
    current_station
  end

  def backward
    return unless @current_station_index != 0
    current_station.train_departure(self)
    @current_station_index -= 1
    current_station.train_arrival(self)
    current_station
  end

  def current_station
    @current_route.station_list[@current_station_index]
  end

  def previous_station
    if @current_station_index != 0
      @current_route.station_list[@current_station_index - 1]
    end
  end

  def next_station
    if @current_station_index != @current_route.station_list.length - 1
      @current_route.station_list[@current_station_index + 1]
    end
  end

  def each_wagon
    @wagons.each.with_index(0) { |wagon, i| yield(wagon, i) }
  end

  private

  attr_writer :speed
end
