# MetaMethods - Collection of methods for easing meta-programming

## Installation

Add this line to your application's Gemfile:

    gem 'meta_methods'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install meta_methods

## Usage

Define new attribute:

```ruby
require 'meta_methods/core'

object = Object.new

MetaMethods::Core.instance.define_attribute object, :new_attribute, "new_attribute_value"
```

or list of attributes:


```ruby
object = Object.new

MetaMethods::Core.instance.define_attributes object, {new_attribute1: "new_attribute_value1",
                                                      new_attribute2: "new_attribute_value2" })
```

Convert ruby fragment into hash:

```
content = "a=1; b=2"

hash = MetaMethods::Core.instance.block_to_hash content
```

Build simplified DSL:

```ruby
def created
  puts "created"
end

def destroyed object
  puts "destroyed: #{object}"
end

def executed object
  puts "executed: #{object}"
end

create_block = lambda { created }
destroy_block = lambda {|object| p destroyed(object) }
execute_block = lambda {|object| p executed(object) }

def build(&block)
  MetaMethods::DslBuilder.instance.evaluate_dsl(create_block, destroy_block, execute_block)
end

def file params
  p "file: #{params}"
end

def directory params
  p "directory: #{params}"
end

build do
  file :name => "Gemfile"
  file :name => "Rakefile", :to_dir => "my_config"
  directory :from_dir => "spec"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
