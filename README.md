## rflags

Tool for storing boolean flags with different backends

### Synopsis:

``` ruby
require 'rflags'

class Flags
  extend RFlags

  flag file_flag: 'tmp/file_flag'

  flag redis_flag: [Redis.current, 'flags:redis_flag']

  flag :variable_flag
end

Flags.file_flag       # #<RFlags::FileFlag>
Flags.file_flag.set?  # File.file?('tmp/file_flag')
Flags.file_flag.set   # File.write('tmp/file_flag', '')
Flags.file_flag.reset # File.delete('tmp/file_flag')

Flags.redis_flag        # #<RFlags::RedisFlag>
Flags.redis_flag.set?   # !redis.get('flags:redis_flag').nil?
Flags.redis_flag.set    # redis.set('flags:redis_flag', '')
Flags.redis_flag.reset  # redis.del('flags:redis_flag')

Flags.variable_flag        # #<RFlags::Flag>
Flags.variable_flag.set?   # @state
Flags.variable_flag.set    # @state = true
Flags.variable_flag.reset  # @state = false
```
