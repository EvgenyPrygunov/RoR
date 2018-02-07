class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = {}
    @train_char = {}
    @train_list = []
    @passenger_type = 0
    @freight_type = 0
  end

  def train_arrival(train, type, wagon_num)
    @train_char[type] = wagon_num
    @trains[train] = @train_char
    @train_list << train
    if type == 'passenger'
      @passenger_type += 1
    else
      @freight_type += 1
    end
  end

  def train_departure(train, type)
    @trains.delete(train)
    @train_list.delete(train)
    if type == 'passenger'
      @passenger_type -= 1
    else
      @freight_type -= 1
    end
  end

  def train_list
    puts "Trains on the station: #{@train_list}"
  end

  def train_type
    puts "Passenger trains: #{@passenger_type}."
    puts "Freight trains: #{@freight_type}."
  end
end

class Route
  attr_reader :dispatch_station
  attr_reader :destination_station
  attr_reader :station_list


  def initialize(dispatch_station, destination_station)
    @dispatch_station = dispatch_station
    @destination_station = destination_station
    @station_list = [@dispatch_station, @destination_station]
  end

  def station_add (name)
    @station_list << name
    @station_list.delete(@destination_station)
    @station_list << @destination_station
  end

  def station_remove (name)
    @station_list.delete(name)
  end

  def route_show
    puts "#{@station_list}"
  end

end

class Train
  attr_accessor :speed
  attr_accessor :wagon_num

  def initialize(train, type, wagon_num)
    @train = train
    @type = type
    @wagon_num = wagon_num
    @first_station = ''
    @current_station = ''
    @current_route = ''
    @station = ''
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
    self.wagon_num -= 1 if @speed == 0 && @wagon_num > 1
  end

  def add_route(route)
    @station = 0
    @current_route = route
    @current_station =  @current_route.station_list[@station]
  end

  def route_up
    if @current_station != @current_route.destination_station
      @station += 1
      @current_station =  @current_route.station_list[@station]
    else
      puts 'Final station!'
    end
  end

  def route_down
    if @current_station != @current_route.dispatch_station
      @station -= 1
      @current_station =  @current_route.station_list[@station]
    else
      puts 'You are at the first station!'
    end
  end

  def closest_stations
    puts "Previous station: #{@current_route.station_list[@station - 1]}"
    puts "Current station: #{@current_route.station_list[@station]}"
    puts "Next station: #{@current_route.station_list[@station + 1]}"
  end

end
