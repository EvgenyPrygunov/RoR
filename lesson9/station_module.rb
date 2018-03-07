module StationModule
  def make_station
    name = @int.ask_for_string('Enter station name.')
    @stations << Station.new(name)
  end

  def stations_list
    @int.stations_list(@stations)
  end
end
