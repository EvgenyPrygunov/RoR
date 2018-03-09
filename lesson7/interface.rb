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
      12 - watch trains list on the station, 13 - watch wagons of trains on the station,
      14 - occupy seat or volume in wagon, 0 - to exit'

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
        when 13
          train_wagons
        when 14
          occupy
        when 0
          break
        else
          puts 'Enter a number from 1 to 12...'
      end
    end
  end

  private

  #These methods are used only inside class Interface
  def make_station
    puts 'Enter station name.'
    name = gets.chomp.to_s
    @stations << Station.new(name)
  end

  def make_train
    puts 'What type of train do you create(enter number 1/2)? 1 - cargo, 2 - passenger.'
    type = gets.chomp.to_i
    begin
      case type
        when 1
          puts 'Enter train number.'
          number = gets.chomp.to_s
          @trains << CargoTrain.new(number)
        when 2
          puts 'Enter train number.'
          number = gets.chomp.to_s
          @trains << PassengerTrain.new(number)
      end
    rescue RuntimeError => e
      puts e.message
      puts 'Number should match \'xxx-xx\' or \'xxxxx\' pattern.'
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
      puts 'Enter total volume.'
      capacity = gets.chomp.to_f
      @trains[train].add_wagon(CargoWagon.new(capacity))
    elsif @trains[train].type == 'passenger'
      puts 'Enter seating capacity.'
      seating_capacity = gets.chomp.to_i
      @trains[train].add_wagon(PassengerWagon.new(capacity))
    end
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

  def stations_list
    @stations.each.with_index(1) { |station, i| puts "#{station.name}: #{i}." }
  end

  def routes_list
    @routes.each.with_index(1) { |route, i| puts "#{route.station_list}: #{i}." }
  end

  def trains_list
    @trains.each.with_index(1) { |train, i| puts "#{train} #{train.number} #{train.type} : #{i}." }
  end

  def trains_on_station
    stations_list
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    @stations[station].each_train { |train| puts "Train number: #{train.number}, type: #{train.type}, wagons: #{train.wagons.size}." }
  end

  def train_wagons
    stations_list
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    trains_list
    puts 'Enter train number to watch it\'s wagons.'
    train = gets.chomp.to_i - 1
    if @stations[station].trains[train].is_a? CargoTrain
      @stations[station].trains[train].each_wagon { |wagon, i| puts "Wagon number: #{i}, type: cargo, free volume: #{wagon.free_space}, occupied volume: #{wagon.occupied}." }
    elsif @stations[station].trains[train].is_a? PassengerTrain
      @stations[station].trains[train].each_wagon { |wagon, i| puts "Wagon number: #{i}, type: passenger, free seats: #{wagon.free_space}, occupied seats: #{wagon.occupied}." }
    end
  end

  def occupy
    stations_list
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    trains_list
    puts 'Enter train number to watch it\'s wagons.'
    train = gets.chomp.to_i - 1
    if @stations[station].trains[train].is_a? CargoTrain
      @stations[station].trains[train].each_wagon { |wagon, i| puts "Wagon number: #{i}, type: cargo, free volume: #{wagon.free_space}, occupied volume: #{wagon.occupied}." }
      puts 'Enter wagon number to occupy volume.'
      wagon = gets.chomp.to_i - 1
      puts 'Enter how much to occupy.'
      volume = gets.chomp.to_f
      @stations[station].trains[train].wagons[wagon].occupy_volume(volume)
    elsif @stations[station].trains[train].is_a? PassengerTrain
      @stations[station].trains[train].each_wagon { |wagon, i| puts "Wagon number: #{i}, type: passenger, free seats: #{wagon.free_space}, occupied seats: #{wagon.occupied}." }
      puts 'Enter wagon number to take seat.'
      wagon = gets.chomp.to_i - 1
      @stations[station].trains[train].wagons[wagon].take_seat
    end
  end

end
