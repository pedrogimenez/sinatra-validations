require "sinatra/base"

module Sinatra
  module Validations
    extend self

    InvalidParameter = Class.new(RuntimeError)

    def validate(parameters, name, options = {})
      default  = options[:default]
      type     = options[:type]
      cast     = true

      if options.key?(:cast)
        cast = options[:cast]
      end

      param = parameters[name]

      if !param
        if options.key?(:default)
          return param = parameters[name] = default
        end

        raise InvalidParameter.new("Missing required parameter #{name}")
      end

      if cast
        if type == Integer
          param = parameters[name] = cast_into_integer(param)
        elsif type == String
          param = parameters[name] = cast_into_string(param)
        else
          raise InvalidParameter.new("Unsupported casting for #{name}")
        end
      end

      if type && !param.is_a?(type)
        raise InvalidParameter.new("Wrong type for #{name}. Expected #{type}, got #{param.class}")
      end
    end

    private

    def cast_into_integer(param)
      begin
        Integer(param)
      rescue
        raise InvalidParameter.new("Unable to convert #{name} into Integer")
      end
    end

    def cast_into_string(param)
      begin
        String(param)
      rescue
        raise InvalidParameter.new("Unable to convert #{name} into String")
      end
    end

    private_class_method :cast_into_integer, :cast_into_string
  end
end
