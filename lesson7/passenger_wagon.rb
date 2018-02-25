require_relative 'company_name'
class PassengerWagon
  include CompanyName

  attr_accessor :occupied
  attr_reader :seating_capacity

  def initialize(seating_capacity)
    @seating_capacity = seating_capacity
    @occupied = 0
  end

  def take_seat
    self.occupied += 1
  end

  def free_seats
    @seating_capacity - @occupied
  end

end
