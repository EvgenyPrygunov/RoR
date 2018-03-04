require_relative 'each_type_wagon'
class Interface < InterfaceLogic
  include EachTypeWagon

  def menu
    loop do
      choice_info
      input = gets.chomp.to_i
      if @choice[input]
        send @choice[input]
      else
        puts 'Input a number from 0 to 14!'
      end
    end
  end

  private

  def choice_info
    puts 'Enter the number:
      1 - station, 2 - train, 3 - route,
      4 - add station to the route, 5 - remove station from the route,
      6 - set route to the train, 7 - add wagon to the train,
      8 - remove wagon from the train, 9 - move train forward,
      10 - move train backward, 11 - watch station list,
      12 - watch trains on the station, 13 - watch train wagons on the station,
      14 - occupy seat or volume in wagon, 0 - to exit'
  end

  def stations_list
    @stations.each.with_index(1) { |station, i| puts "#{station.name}: #{i}." }
  end

  def routes_list
    @routes.each.with_index(1) do |route, i|
      puts "#{route.station_list}: #{i}."
    end
  end

  def trains_list
    @trains.each.with_index(1) do |train, i|
      puts "#{train} #{train.number} #{train.type} : #{i}."
    end
  end

  def trains_on_station
    stations_list
    puts 'Enter station number.'
    station = gets.chomp.to_i - 1
    each_train_station(station)
  end

  def train_wagons
    stations_list
    puts 'Enter station number.'
    station = gets.chomp.to_i - 1
    each_train_station(station)
    puts 'Enter train number to watch it\'s wagons.'
    train = gets.chomp.to_i - 1
    train_wagon_list(station, train)
  end

  def train_wagon_list(station, train)
    each_cargo_wagon(station, train) if
      @stations[station].trains[train].is_a? CargoTrain
    each_passenger_wagon(station, train) if
      @stations[station].trains[train].is_a? PassengerTrain
  end

  def each_train_station(station)
    @stations[station].each_train do |train, i|
      puts "#{i}: #{train.number}, #{train.type}, #{train.wagons.size} wagons."
    end
  end
end
