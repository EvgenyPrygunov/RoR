module RouteModule
  def make_route
    @int.stations_list(@stations)
    dispatch = @int.ask_for_number('Enter number of dispatch station.')
    destination = @int.ask_for_number('Enter number of destination station.')
    @routes << Route.new(@stations[dispatch], @stations[destination])
  end

  def route_station_add
    @int.routes_list(@routes)
    route = @int.ask_for_number('Enter number of route.')
    @int.stations_list(@stations)
    station = @int.ask_for_number('Enter number of station to add.')
    @routes[route].station_add(@stations[station])
  end

  def route_station_delete
    @int.routes_list(@routes)
    route = @int.ask_for_number('Enter number of route.')
    @int.stations_list(@stations)
    station = @int.ask_for_number('Enter number of station to delete.')
    @routes[route].station_remove(@stations[station])
  end
end
