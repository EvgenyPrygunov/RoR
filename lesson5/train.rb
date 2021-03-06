require_relative 'company_name'
require_relative 'instance_counter'

class Train
  include CompanyName
  include InstanceCounter

  attr_reader :speed, :number

  @@all = {}

  def self.find(number)
    @@all[number]
  end

  def initialize(number)
    @number = number
    @current_station_index = 0
    @speed = 0
    @wagons = []
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
    @wagons << wagon if @speed == 0 && right_type?(wagon)
  end

  def remove_wagon
    @wagons.pop if @speed == 0
  end

  def add_route(route)
    @current_route = route
    @current_station_index = 0
    current_station.train_arrival(self)
  end

  def forward
    if @current_station_index != @current_route.station_list.length - 1
      current_station.train_departure(self)
      @current_station_index += 1
      current_station.train_arrival(self)
      current_station
    end
  end

  def backward
    if @current_station_index != 0
      current_station.train_departure(self)
      @current_station_index -= 1
      current_station.train_arrival(self)
      current_station
    end
  end

  def current_station
    @current_route.station_list[@current_station_index]
  end

  def previous_station
    @current_route.station_list[@current_station_index - 1] if @current_station_index != 0
  end

  def next_station
    @current_route.station_list[@current_station_index + 1] if @current_station_index != @current_route.station_list.length - 1
  end

  private

  #This attr_writer is used only inside class Train (by other methods)
  attr_writer :speed

end
