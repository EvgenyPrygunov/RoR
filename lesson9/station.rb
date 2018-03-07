require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :name, :trains
  attr_accessor_with_history :train

  validate :name, :presence

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
    @trains.each.with_index(0) { |train, i| yield(train, i) }
  end
end
