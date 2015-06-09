require 'rflags/flag'
require 'rflags/file_flag'
require 'rflags/redis_flag'


module RFlags
  def flag(definition)
    name, backend = resolve_flag_params(definition)
    instance_variable_set("@#{name}".to_sym, backend)
    instance_eval <<-MTD, __FILE__, __LINE__
      def #{name}
        @#{name}
      end
    MTD
  end

  def lazy_flag(name, &block)
    if !block
      raise "RFlags##{__method__} needs a block"
    end

    resolve = -> do
      opts = block.call
      resolve_flag_backend_class(opts).new(*opts)
    end

    instance_variable_set(:"@#{name}_block", resolve)
    instance_eval(<<-MTD, __FILE__, __LINE__)
      def #{name}
        @#{name} ||= @#{name}_block.call
      end
    MTD
  end

  private

  def resolve_flag_params(definition)
    case definition
    when String, Symbol
      [definition, RFlags::Flag.new]
    when Hash
      name = definition.keys[0]

      backend_opts = definition[name]
      backend_class = resolve_flag_backend_class(backend_opts)

      [name, backend_class.new(*backend_opts)]
    else
      raise TypeError, "Can't handle #{definition.class}"
    end
  end

  def resolve_flag_backend_class(opts)
    case opts
    when String, Pathname
      RFlags::FileFlag
    when Array
      class_name = opts[0].class
      ::Object.const_get("::RFlags::#{class_name}Flag")
    else
      raise TypeError, "Can't handle #{opts.class}"
    end
  end
end
