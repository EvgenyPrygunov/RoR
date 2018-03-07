module TrainModule
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
    @int.each_train_station(station, @stations)
  end
end
