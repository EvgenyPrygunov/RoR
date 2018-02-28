require_relative 'instance_counter'
class Route
  include InstanceCounter
  attr_reader :station_list
  def initialize(dispatch_station, destination_station)
    @dispatch_station = dispatch_station
    @destination_station = destination_station
    validate!
    @station_list = [dispatch_station, destination_station]
    register_instance
  end

  def station_add(station)
    @station_list.insert(-2, station)
  end

  def station_remove(station)
    @station_list.delete(station) if
        station != @station_list.first && station != @station_list.last
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Dispatch station can\'t be nil' if @dispatch_station.nil?
    raise 'Destination station can\'t be nil' if @destination_station.nil?
    raise 'Dispatch station must be a Station class instance' unless
        @dispatch_station.is_a? Station
    raise 'Destination station must be a Station class instance' unless
        @destination_station.is_a? Station
    true
  end
end
