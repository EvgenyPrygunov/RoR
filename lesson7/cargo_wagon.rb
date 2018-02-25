require_relative 'company_name'
class CargoWagon
  include CompanyName

  attr_accessor :occupied
  attr_reader :total_volume

  def initialize(total_volume)
    @total_volume = total_volume
    @occupied = 0
  end

  def occupy_volume(volume)
    self.occupied += volume
  end

  def free_volume
    @total_volume - @occupied
  end

end
