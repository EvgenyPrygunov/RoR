module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def count
      if @instances.nil?
        @instances = 1
      else
        @instances += 1
      end
    end
  end

  module InstanceMethods

    private

    def register_instance
      self.class.count
    end
  end

end
