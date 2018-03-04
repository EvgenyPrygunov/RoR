require_relative 'each_type_wagon'
class InterfaceLogic
  include EachTypeWagon

  def initialize
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

  private

  def make_station
    puts 'Enter station name.'
    name = gets.chomp.to_s
    @stations << Station.new(name)
  end

  def make_train
    begin
      puts 'What type of train do you create? 1 - cargo, 2 - passenger.'
      type = gets.chomp.to_i
      puts 'Enter train number.'
      number = gets.chomp.to_s
      @trains << CargoTrain.new(number) if type == 1
      @trains << PassengerTrain.new(number) if type == 2
    rescue RuntimeError => e
      puts e.message
      retry
    end
    puts "Train №#{number} created."
  end

  def make_route
    stations_list
    puts 'Enter number of dispatch station.'
    dispatch = gets.chomp.to_i - 1
    puts 'Enter number of destination station.'
    destination = gets.chomp.to_i - 1
    @routes << Route.new(@stations[dispatch], @stations[destination])
  end

  def route_station_add
    routes_list
    puts 'Enter number of route.'
    route = gets.chomp.to_i - 1
    stations_list
    puts 'Enter number of station to add.'
    station = gets.chomp.to_i - 1
    @routes[route].station_add(@stations[station])
  end

  def route_station_delete
    routes_list
    puts 'Enter number of route.'
    route = gets.chomp.to_i - 1
    stations_list
    puts 'Enter number of station to delete.'
    station = gets.chomp.to_i - 1
    @routes[route].station_remove(@stations[station])
  end

  def route_to_train
    trains_list
    puts 'Enter train number to add route.'
    train = gets.chomp.to_i - 1
    routes_list
    puts 'Enter route number.'
    route = gets.chomp.to_i - 1
    @trains[train].add_route(@routes[route])
  end

  def add_wagon
    trains_list
    puts 'Enter train number to add wagon.'
    train = gets.chomp.to_i - 1
    if @trains[train].type == 'cargo'
      add_cargo_wagon(train)
    elsif @trains[train].type == 'passenger'
      add_passenger_wagon(train)
    end
  end

  def add_cargo_wagon(train)
    puts 'Enter total volume.'
    capacity = gets.chomp.to_f
    @trains[train].add_wagon(CargoWagon.new(capacity))
  end

  def add_passenger_wagon(train)
    puts 'Enter seating capacity.'
    capacity = gets.chomp.to_i
    @trains[train].add_wagon(PassengerWagon.new(capacity))
  end

  def remove_wagon
    trains_list
    puts 'Enter train number to remove wagon.'
    train = gets.chomp.to_i - 1
    @trains[train].remove_wagon
  end

  def train_forward
    trains_list
    puts 'Enter train number to move forward.'
    train = gets.chomp.to_i - 1
    @trains[train].forward
  end

  def train_backward
    trains_list
    puts 'Enter train number to move backward.'
    train = gets.chomp.to_i - 1
    @trains[train].backward
  end

  def occupy
    stations_list
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    trains_list
    puts 'Enter train number to watch it\'s wagons.'
    train = gets.chomp.to_i - 1
    occupy_cargo(station, train) if
      @stations[station].trains[train].is_a? CargoTrain
    occupy_passenger(station, train) if
      @stations[station].trains[train].is_a? PassengerTrain
  end

  def occupy_cargo(station, train)
    each_cargo_wagon(station, train)
    puts 'Enter wagon number to occupy volume.'
    wagon = gets.chomp.to_i - 1
    puts 'Enter how much to occupy.'
    volume = gets.chomp.to_f
    @stations[station].trains[train].wagons[wagon].occupy_volume(volume)
  end

  def occupy_passenger(station, train)
    each_passenger_wagon(station, train)
    puts 'Enter wagon number to take seat.'
    wagon = gets.chomp.to_i - 1
    @stations[station].trains[train].wagons[wagon].take_seat
  end
end
