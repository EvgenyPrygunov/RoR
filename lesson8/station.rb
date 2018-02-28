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

  def each_train
    @trains.each.with_index(1) { |train, i| yield(train, i) }
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Name can\'t be nil' if name.nil?
    true
  end
end
