require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :station_list

  def initialize(dispatch_station, destination_station)
    @station_list = [dispatch_station, destination_station]
    register_instance
    validate!
  end

  def station_add(station)
    @station_list.insert(-2, station)
  end

  def station_remove(station)
    @station_list.delete(station) if station != @station_list.first && station != @station_list.last
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise 'Dispatch station can\'t be nil' if @station_list[0].nil?
    raise 'Destination station can\'t be nil' if @station_list.last.nil?
    true
  end

end
