require_relative 'accessors'

class CargoWagon < Wagon
  include Accessors

  attr_accessor_with_history :capacity

  def initialize(capacity)
    super(capacity)
  end

  def occupy_volume(volume)
    self.occupied += volume
  end
end
