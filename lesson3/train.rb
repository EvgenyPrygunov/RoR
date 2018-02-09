class Train
  attr_accessor :speed, :wagon_num
  attr_reader :name, :type

  def initialize(name, type, wagon_num)
    @name = name
    @type = type
    @wagon_num = wagon_num
    @current_station = 0
    @current_route = 0
    @speed = 0
  end

  def speed_stop
    self.speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def add_wagon
    self.wagon_num += 1 if @speed == 0
  end

  def remove_wagon
    self.wagon_num -= 1 if @speed == 0
  end

  def add_route(route)
    @current_route = route
    @current_station = 0
    @current_route.station_list[@current_station]
  end

  def route_up
    if @current_station != @current_route.station_list.length - 1
      @current_station += 1
      @current_route.station_list[@current_station]
    end
  end

  def route_down
    if @current_station != 0
      @current_station -= 1
      @current_route.station_list[@current_station]
    end
  end

  def closest_stations
    if @current_station == 0
      @current_route.station_list.slice(@current_station, 2)
    elsif @current_station > 0
      @current_route.station_list.slice(@current_station - 1, 3)
    elsif @current_station == @current_route.station_list.last
      @current_route.station_list.slice(-2, 2)
    end
  end

end
