class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @train_list = []
  end

  def train_arrival(train, type, wagon_num)
    @train_list << [train, type, wagon_num]
  end

  def train_departure(train)
    @train_list.delete_if{ |t| t[0] == train }
  end

  def train_list
    @train_list
  end

  def train_type
    count = Hash.new(0)
    @train_list.each { |train| count[train[1]] += 1 }
    count
  end
end

class Route
  attr_reader :station_list


  def initialize(dispatch_station, destination_station)
    #@dispatch_station = dispatch_station
    #@destination_station = destination_station
    @station_list = [dispatch_station, destination_station]
  end

  def station_add(station)
    @station_list.insert(-2, station)
  end

  def station_remove(station)
    @station_list.delete(station)
  end

  def route_show
    @station_list
  end

end

class Train
  attr_accessor :speed

  def initialize(train, type, wagon_num)
    @train_list = [train, type, wagon_num]
    @current_station = 0
    @route = []
    @speed = 0
  end

  def speed_stop
    self.speed = 0
  end

  def speed_up
    self.speed += 10
  end

  def add_wagon
    @train_list[2] += 1 if @speed == 0
  end

  def remove_wagon
    @train_list[2] -= 1 if @speed == 0
  end

  def wagon_num
    @train_list[2]
  end

  def add_route(route)
    @route = route.route_show
    @current_station = 0
    @route[@current_station]
  end

  def route_up
    if @current_station != @route.length - 1
      @current_station += 1
      @route[@current_station]
    end
  end

  def route_down
    if @current_station != 0
      @current_station -= 1
      @route[@current_station]
    end
  end

  def closest_stations
    if @current_station == 0
      @route.slice(@current_station, 2)
    elsif @current_station > 0
      @route.slice(@current_station - 1, 3)
    elsif @current_station == @route.last
      @route.slice(-2, 2)
    end
  end

end
