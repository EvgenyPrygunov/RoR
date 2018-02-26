class CargoWagon < Wagon

  def initialize(capacity)
    super(capacity)
  end

  def occupy_volume(volume)
    self.occupied += volume
  end

end
