require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Route
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :station_list
  attr_accessor_with_history :station
  strong_attr_accessor :train, :Train

  validate :dispatch_station, :presence
  validate :destination_station, :presence
  validate :dispatch_station, :type, Station
  validate :destination_station, :type, Station

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
end
