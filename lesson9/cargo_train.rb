require_relative 'accessors'
require_relative 'validation'

class CargoTrain < Train
  include Accessors
  include Validation

  attr_accessor :type
  strong_attr_accessor :wagon, :Wagon

  validate :number, :presence
  validate :number, :length
  validate :number, :format, NUMBER_FORMAT

  def initialize(number)
    super(number)
    @type = 'cargo'
  end

  def right_type?(wagon)
    wagon.is_a? CargoWagon
  end
end
