class PassengerTrain < Train
  attr_accessor :type

  def initialize(name)
    super(name)
    @type = 'passenger'
  end

  def right_type?(wagon)
    wagon.is_a?PassengerWagon
  end

end
