require_relative 'company_name'
class Wagon
  include CompanyName

  attr_accessor :occupied
  attr_reader :capacity

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
  end

  def free_space
    @capacity - @occupied
  end

end
