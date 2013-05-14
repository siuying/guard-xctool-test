# guard-xctool-test

Xctool test guard allows you to automically & intelligently aunch specs when files are modified.

## Installation

Add this line to your application's Gemfile:

    gem 'guard-xctool-test'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install guard-xctool-test

## Dependency

- Ruby 1.9.3 or above
- [xctool](https://github.com/facebook/xctool)

## Usage

TODO: Write usage instructions here

## Guardfile

```ruby
guard 'xctool-test', :test_target => 'YouAppTests', :test_paths => 'YouAppTests' do
  watch(%r{YouApp/(.+)\.(m|mm)$})
  watch(%r{YouAppTests/(.+)\.(m|mm)$})
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
