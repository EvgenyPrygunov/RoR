require_relative 'each_type_wagon'
class InterfaceLogic
  include EachTypeWagon

  def initialize
    @int = Interface.new
    @stations = []
    @routes = []
    @trains = []
    @choice = {
      1 => :make_station, 2 => :make_train, 3 => :make_route,
      4 => :route_station_add, 5 => :route_station_delete,
      6 => :route_to_train, 7 => :add_wagon, 8 => :remove_wagon,
      9 => :train_forward, 10 => :train_backward, 11 => :stations_list,
      12 => :trains_on_station, 13 => :train_wagons, 14 => :occupy, 0 => :exit
    }
  end

  def menu
    loop do
      @int.choice_info
      input = gets.chomp.to_i
      if @choice[input]
        send @choice[input]
      else
        puts 'Input a number from 0 to 14!'
      end
    end
  end

  private

  # Stations

  def make_station
    name = @int.ask_for_string('Enter station name.')
    @stations << Station.new(name)
  end

  def stations_list
    @int.stations_list(@stations)
  end

  # Routes

  def make_route
    @int.stations_list(@stations)
    dispatch = @int.ask_for_number('Enter number of dispatch station.')
    destination = @int.ask_for_number('Enter number of destination station.')
    @routes << Route.new(@stations[dispatch], @stations[destination])
  end

  def route_station_add
    @int.routes_list(@routes)
    route = @int.ask_for_number('Enter number of route.')
    @int.stations_list(@stations)
    station = @int.ask_for_number('Enter number of station to add.')
    @routes[route].station_add(@stations[station])
  end

  def route_station_delete
    @int.routes_list(@routes)
    route = @int.ask_for_number('Enter number of route.')
    @int.stations_list(@stations)
    station = @int.ask_for_number('Enter number of station to delete.')
    @routes[route].station_remove(@stations[station])
  end

  # Trains

  def make_train
    begin
      type = @int.ask_for_number('What type? 1 - cargo, 2 - passenger.')
      number = @int.ask_for_string('Enter train number.')
      @trains << CargoTrain.new(number) if type == 1
      @trains << PassengerTrain.new(number) if type == 2
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts "Train №#{number} created."
  end

  def route_to_train
    @int.trains_list(@trains)
    train = @int.ask_for_number('Enter train number to add route.')
    @int.routes_list(@routes)
    route = @int.ask_for_number('Enter route number.')
    @trains[train].add_route(@routes[route])
  end

  def train_forward
    @int.trains_list(@trains)
    train = @int.ask_for_number('Enter train number to move forward.')
    @trains[train].forward
  end

  def train_backward
    @int.trains_list(@trains)
    train = @int.ask_for_number('Enter train number to move backward.')
    @trains[train].backward
  end

  def trains_on_station
    @int.stations_list(@stations)
    station = @int.ask_for_number('Enter station number.')
    each_train_station(station)
  end

  def each_train_station(station)
    @stations[station].each_train do |train, i|
      puts "#{i}: #{train.number}, #{train.type}, #{train.wagons.size} wagons."
    end
  end

  # Wagons

  def add_wagon
    @int.trains_list(@trains)
    train = @int.ask_for_number('Enter train number to add wagon.')
    if @trains[train].type == 'cargo'
      add_cargo_wagon(train)
    elsif @trains[train].type == 'passenger'
      add_passenger_wagon(train)
    end
  end

  def add_cargo_wagon(train)
    capacity = @int.ask_for_number('Enter total volume.')
    @trains[train].add_wagon(CargoWagon.new(capacity))
  end

  def add_passenger_wagon(train)
    capacity = @int.ask_for_number('Enter seating capacity.')
    @trains[train].add_wagon(PassengerWagon.new(capacity))
  end

  def remove_wagon
    @int.trains_list(@trains)
    train = @int.ask_for_number('Enter train number to remove wagon.')
    @trains[train].remove_wagon
  end

  def train_wagons
    stations_list
    station = @int.ask_for_number('Enter station number.')
    each_train_station(station)
    train = @int.ask_for_number('Enter train number to watch it\'s wagons.')
    train_wagon_list(station, train)
  end

  def train_wagon_list(station, train)
    if @stations[station].trains[train].is_a? CargoTrain
      each_cargo_wagon(station, train)
    elsif @stations[station].trains[train].is_a? PassengerTrain
      each_passenger_wagon(station, train)
    end
  end

  def occupy
    stations_list
    station = @int.ask_for_number('Enter station number to watch trains on it.')
    each_train_station(station)
    train = @int.ask_for_number('Enter train number to watch it\'s wagons.')
    if @stations[station].trains[train].is_a? CargoTrain
      occupy_cargo(station, train)
    elsif @stations[station].trains[train].is_a? PassengerTrain
      occupy_passenger(station, train)
    end
  end

  def occupy_cargo(station, train)
    each_cargo_wagon(station, train)
    wagon = @int.ask_for_number('Enter wagon number to occupy volume.')
    volume = @int.ask_for_number('Enter how much to occupy.')
    @stations[station].trains[train].wagons[wagon].occupy_volume(volume)
  end

  def occupy_passenger(station, train)
    each_passenger_wagon(station, train)
    wagon = @int.ask_for_number('Enter wagon number to take seat.')
    @stations[station].trains[train].wagons[wagon].take_seat
  end
end
