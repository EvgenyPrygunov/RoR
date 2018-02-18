class CargoTrain < Train
  attr_accessor :type

  def initialize(name)
    super(name)
    @type = 'cargo'
  end

  def right_type?(wagon)
    wagon.is_a?CargoWagon
  end

end
