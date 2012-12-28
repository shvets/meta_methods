# MetaMethods - Collection of methods for easing meta-programming

## Installation

Add this line to your application's Gemfile:

    gem 'meta_methods'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install meta_methods

## Usage

```ruby
require 'meta_methods'

class MyNewClass

  include MetaMethods

  def test
    puts metaclass
  end

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
