require 'rflags/flag'
require 'rflags/file_flag'
require 'rflags/redis_flag'


module RFlags
  def flag(definition)
    case definition
    when Symbol, String
      define_flag(definition, RFlags::Flag.new)
    when Hash
      definition.each do |name, backend|
        define_flag(name, resolve_flag_backend(backend))
      end
    else
      raise TypeError,
        "RFlags#flag expects Symbol, String or Hash, but have #{definition.class}"
    end
  end

  private

  def define_flag(name, backend)
    instance_variable_set(:"@#{name}", backend)
    instance_eval(<<-MTD, __FILE__, __LINE__)
      def #{name}; @#{name}; end
    MTD
  end

  def resolve_flag_backend(backend)
    case backend
    when String
      RFlags::FileFlag.new(backend)
    when Array
      ::Object.const_get("::RFlags::#{backend[0].class}Flag")
        .new(*backend)
    else
      raise TypeError,
        "Wrong backend definition for RFlags#flag.\n" <<
        "Backend should be instance of String or Array, but have #{backend.class}"
    end
  end
end
