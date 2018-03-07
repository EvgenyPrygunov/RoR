require_relative 'station_module'
require_relative 'route_module'
require_relative 'train_module'

class InterfaceLogic
  include StationModule
  include RouteModule
  include TrainModule

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
    @int.each_train_station(station, @stations)
    train = @int.ask_for_number('Enter train number to watch it\'s wagons.')
    train_wagon_list(station, train)
  end

  def train_wagon_list(station, train)
    if @stations[station].trains[train].is_a? CargoTrain
      @int.each_cargo_wagon(station, train, @stations)
    elsif @stations[station].trains[train].is_a? PassengerTrain
      @int.each_passenger_wagon(station, train, @stations)
    end
  end

  def occupy
    stations_list
    station = @int.ask_for_number('Enter station number to watch trains on it.')
    @int.each_train_station(station, @stations)
    train = @int.ask_for_number('Enter train number to watch it\'s wagons.')
    if @stations[station].trains[train].is_a? CargoTrain
      occupy_cargo(station, train)
    elsif @stations[station].trains[train].is_a? PassengerTrain
      occupy_passenger(station, train)
    end
  end

  def occupy_cargo(station, train)
    @int.each_cargo_wagon(station, train, @stations)
    wagon = @int.ask_for_number('Enter wagon number to occupy volume.')
    volume = @int.ask_for_number('Enter how much to occupy.')
    @stations[station].trains[train].wagons[wagon].occupy_volume(volume)
  end

  def occupy_passenger(station, train)
    @int.each_passenger_wagon(station, train, @stations)
    wagon = @int.ask_for_number('Enter wagon number to take seat.')
    @stations[station].trains[train].wagons[wagon].take_seat
  end
end
