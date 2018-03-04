module EachTypeWagon
  def each_cargo_wagon(station, train)
    @stations[station].trains[train].each_wagon do |w, i|
      puts "#{i}, cargo, free: #{w.free_space}, occupied: #{w.occupied}"
    end
  end

  def each_passenger_wagon(station, train)
    @stations[station].trains[train].each_wagon do |w, i|
      puts "#{i}, passenger, free: #{w.free_space}, occupied: #{w.occupied}"
    end
  end
end
