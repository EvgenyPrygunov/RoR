class PassengerTrain < Train
  attr_accessor :type

  def initialize(name)
    super(name)
    @type = 'passenger'
  end

  def add_wagon(wagon)
    super if wagon.type == self.type
  end

end
