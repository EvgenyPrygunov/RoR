require_relative 'company_name'
require_relative 'accessors'
require_relative 'validation'

class Wagon
  include CompanyName
  include Accessors
  include Validation

  attr_accessor :occupied
  attr_reader :capacity
  strong_attr_accessor :station, :Station

  validate :capacity, :presence

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
  end

  def free_space
    @capacity - @occupied
  end
end
