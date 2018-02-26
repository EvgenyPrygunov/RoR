require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all << self
    register_instance
  end

  def train_arrival(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end

  def train_type(type)
    @trains.count { |train| train.type == type }
  end

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise 'Name can\'t be nil' if name.nil?
    true
  end

end
