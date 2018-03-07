module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, params = nil)
      @validations ||= []
      @validations << { name: name, type: type, params: params }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        validation_method = "validate_#{validation[:type]}".to_sym
        var = instance_variable_get("@#{validation[:name]}".to_sym)
        if validation[:params].nil?
          send(validation_method, var)
        else
          send(validation_method, var, validation[:params])
        end
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    protected

    def validate_presence(value)
      if value.nil? || value == ''
        raise 'Can\'t be nil or empty string.'
      end
    end

    def validate_format(value, regular)
      if value !~ regular
        raise 'Invalid format.'
      end
    end

    def validate_type(value, type)
      unless value.is_a? type
        raise 'Invalid type.'
      end
    end

    def validate_length(value)
      if value.to_s.length < 5
        raise 'Should be at least 5 symbols.'
      end
    end
  end
end
