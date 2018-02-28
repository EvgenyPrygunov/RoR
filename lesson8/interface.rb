class Interface
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

  # These methods are used only inside class Interface
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

  def make_station
    puts 'Enter station name.'
    name = gets.chomp.to_s
    @stations << Station.new(name)
  end

  def make_train
    puts 'What type of train do you create? 1 - cargo, 2 - passenger.'
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
      else
        puts 'Input 1 or 2...'
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
      capacity = gets.chomp.to_i
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
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    @stations[station].each_train do |train, i|
      print "Train number #{i}: #{train.number}, type: #{train.type}, ",
            "wagons: #{train.wagons.size}.\n"
    end
  end

  def train_wagons
    stations_list
    puts 'Enter station number to watch trains on it.'
    station = gets.chomp.to_i - 1
    @stations[station].each_train do |train, i|
      print "Train number #{i}: #{train.number}, type: #{train.type}, ",
            "wagons: #{train.wagons.size}.\n"
    end
    puts 'Enter train number to watch it\'s wagons.'
    train = gets.chomp.to_i - 1
    if @stations[station].trains[train].is_a? CargoTrain
      @stations[station].trains[train].each_wagon do |wagon, i|
        print "Wagon number: #{i}, type: cargo, free volume: ",
              "#{wagon.free_space}, occupied volume: #{wagon.occupied}.\n"
      end
    elsif @stations[station].trains[train].is_a? PassengerTrain
      @stations[station].trains[train].each_wagon do |wagon, i|
        print "Wagon number: #{i}, type: passenger, free seats: ",
              "#{wagon.free_space}, occupied seats: #{wagon.occupied}.\n"
      end
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
      @stations[station].trains[train].each_wagon do |wagon, i|
        print "Wagon number: #{i}, type: cargo, free volume: ",
              "#{wagon.free_space}, occupied volume: #{w.occupied}.\n"
      end
      puts 'Enter wagon number to occupy volume.'
      wagon = gets.chomp.to_i - 1
      puts 'Enter how much to occupy.'
      volume = gets.chomp.to_f
      @stations[station].trains[train].wagons[wagon].occupy_volume(volume)
    elsif @stations[station].trains[train].is_a? PassengerTrain
      @stations[station].trains[train].each_wagon do |w, i|
        print "Wagon number: #{i}, type: passenger, free seats: ",
              "#{w.free_space}, occupied seats: #{w.occupied}.\n"
      end
      puts 'Enter wagon number to take seat.'
      wagon = gets.chomp.to_i - 1
      @stations[station].trains[train].wagons[wagon].take_seat
    end
  end
end
