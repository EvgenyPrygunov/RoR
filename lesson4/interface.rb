class Interface

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def choice
    loop do
      puts 'Enter the number:
      1 - station, 2 - train, 3 - route,
      4 - add station to the route, 5 - remove station from the route,
      6 - set route to the train, 7 - add wagon to the train,
      8 - remove wagon from the train, 9 - move train forward in the route,
      10 - move train backward in the route, 11 - watch station list,
      12 - watch trains list on the station, 0 - to exit'

      choice = gets.chomp.to_i

      case choice
        when 1
          make_station
        when 2
          make_train
        when 3
          make_route
        when 4
          route_station_add
        when 5
          route_station_delete
        when 6
          route_to_train
        when 7
          add_wagon
        when 8
          remove_wagon
        when 9
          train_forward
        when 10
          train_backward
        when 11
          stations_list
        when 12
          trains_on_station
        when 0
          break
        else
          puts 'Enter a number from 1 to 12...'
      end
    end
  end

  private

  #These methods are used only inside class Interface
  def make_station #good!
    puts 'Enter station name.'
    name = gets.chomp.to_s
    @stations << Station.new(name)
  end

  def make_train #good!
    puts 'What type of train do you create(enter number 1/2)? 1 - cargo, 2 - passenger'
    type = gets.chomp.to_i
    case type
      when 1
        puts 'Enter train name.'
        name = gets.chomp.to_s
        @trains << CargoTrain.new(name)
      when 2
        puts 'Enter train name.'
        name = gets.chomp.to_s
        @trains << PassengerTrain.new(name)
      else
        puts 'Enter 1 or 2...'
    end
  end

  def make_route #good!
    stations_list
    puts 'Enter number of dispatch station.'
    dispatch = gets.chomp.to_i - 1
    puts 'Enter number of destination station.'
    destination = gets.chomp.to_i - 1
    @routes << Route.new(@stations[dispatch], @stations[destination])
  end

  def route_station_add #good!
    routes_list
    puts 'Enter number of route.'
    route = gets.chomp.to_i - 1
    stations_list
    puts 'Enter number of station to add.'
    station = gets.chomp.to_i - 1
    @routes[route].station_add(@stations[station])
  end

  def route_station_delete #good!
    routes_list
    puts 'Enter number of route.'
    route = gets.chomp.to_i - 1
    stations_list
    puts 'Enter number of station to delete.'
    station = gets.chomp.to_i - 1
    @routes[route].station_remove(@stations[station])
  end

  def route_to_train #good!
    trains_list
    puts 'Enter train number to add route.'
    train = gets.chomp.to_i - 1
    routes_list
    puts 'Enter route number.'
    route = gets.chomp.to_i - 1
    @trains[train].add_route(@routes[route])
  end

  def add_wagon #good!
    trains_list
    puts 'Enter train number to add wagon.'
    train = gets.chomp.to_i - 1
    if @trains[train].type == 'cargo'
      @trains[train].add_wagon(CargoWagon.new)
    elsif @trains[train].type == 'passenger'
      @trains[train].add_wagon(PassengerWagon.new)
    end
  end

  def remove_wagon #good!
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

  def stations_list
    @stations.each.with_index(1) { |station, i| puts "#{station.name}: #{i}." }
  end

  def routes_list
    @routes.each.with_index(1) { |route, i| puts "#{route.station_list}: #{i}." }
  end

  def trains_list
    @trains.each.with_index(1) { |train, i| puts "#{train} #{train.name} #{train.type} : #{i}." }
  end

  def trains_on_station
    stations_list
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    @stations[station].trains.each { |train| puts "Trains: #{train} #{train.name} #{train.type}." }
  end

end
