require_relative 'accessors'

class PassengerWagon < Wagon
  include Accessors

  attr_accessor_with_history :capacity

  def initialize(capacity)
    super(capacity)
  end

  def take_seat
    self.occupied += 1
  end
end
