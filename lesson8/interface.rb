class Interface
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

  def stations_list(stations)
    stations.each.with_index(0) { |station, i| puts "#{i}: #{station.name}." }
  end

  def routes_list(routes)
    routes.each.with_index(0) do |route, i|
      puts "#{i}: #{route.station_list}."
    end
  end

  def trains_list(trains)
    trains.each.with_index(0) do |train, i|
      puts "#{i}: #{train} #{train.number} #{train.type}."
    end
  end

  def ask_for_string(message)
    puts message
    gets.chomp.to_s
  end

  def ask_for_number(message)
    puts message
    gets.chomp.to_i
  end

  def each_cargo_wagon(station, train, stations)
    stations[station].trains[train].each_wagon do |w, i|
      puts "#{i}, cargo, free: #{w.free_space}, occupied: #{w.occupied}"
    end
  end

  def each_passenger_wagon(station, train, stations)
    stations[station].trains[train].each_wagon do |w, i|
      puts "#{i}, passenger, free: #{w.free_space}, occupied: #{w.occupied}"
    end
  end

  def each_train_station(station, stations)
    stations[station].each_train do |train, i|
      puts "#{i}: #{train.number}, #{train.type}, #{train.wagons.size} wagons."
    end
  end
end
