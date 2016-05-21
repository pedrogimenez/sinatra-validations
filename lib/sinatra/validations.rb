require "sinatra/base"

module Sinatra
  module Validations
    extend self

    InvalidParameter = Class.new(RuntimeError)

    def validate(parameters, key, options = {})
      default  = options[:default]
      type     = options[:type]
      cast     = true

      if options.key?(:cast)
        cast = options[:cast]
      end

      param = parameters[key]

      if !param
        if options.key?(:default)
          return param = parameters[key] = default
        end

        raise InvalidParameter.new("Missing required parameter #{key}")
      end

      if cast
        if type == Integer
          param = parameters[key] = cast_into_integer(param, key)
        elsif type == String
          param = parameters[key] = cast_into_string(param, key)
        else
          raise InvalidParameter.new("Unsupported casting for #{key}")
        end
      end

      if type && !param.is_a?(type)
        raise InvalidParameter.new("Wrong type for #{key}. Expected #{type}, got #{param.class}")
      end
    end

    private

    def cast_into_integer(param, key)
      begin
        Integer(param)
      rescue
        raise InvalidParameter.new("Unable to convert #{key} into Integer")
      end
    end

    def cast_into_string(param, key)
      begin
        String(param)
      rescue
        raise InvalidParameter.new("Unable to convert #{key} into String")
      end
    end

    private_class_method :cast_into_integer, :cast_into_string
  end
end
