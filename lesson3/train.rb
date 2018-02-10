class Train
  attr_reader :name, :type, :speed, :wagon_num

  def initialize(name, type, wagon_num)
    @name = name
    @type = type
    @wagon_num = wagon_num
    @current_station_index = 0
    @current_route = 0
    @speed = 0
  end

  def speed_stop
    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def add_wagon
    @wagon_num += 1 if @speed == 0
  end

  def remove_wagon
    @wagon_num -= 1 if @speed == 0 && @wagon_num != 0
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
      @current_route.station_list[@current_station_index]
    end
  end

  def backward
    if @current_station_index != 0
      current_station.train_departure(self)
      @current_station_index -= 1
      current_station.train_arrival(self)
      @current_route.station_list[@current_station_index]
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

end
