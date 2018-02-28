class PassengerWagon < Wagon
  def initialize(capacity)
    super(capacity)
  end

  def take_seat
    self.occupied += 1
  end
end
