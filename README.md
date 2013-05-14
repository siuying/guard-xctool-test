# guard-xctool-test

guard-xctool-test allows you to automically & intelligently launch specs when files are modified.

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


## Guardfile

```ruby
guard 'xctool-test' do
  watch(%r{YourApp/(.+)\.(m|mm)$})
  watch(%r{YourAppTests/(.+)\.(m|mm)$})
end
```

## Options

By default, xctool-test find the folder for projects and find a target that look like test.
You can supply your target by using ```test_target``` option.

```ruby
guard 'xctool-test', :test_target => 'YourAppTests' do
  watch(%r{YourApp/(.+)\.(m|mm)$})
  watch(%r{YourAppTests/(.+)\.(m|mm)$})
end
```

By default, xctool-test check all files under current folder for tests. You can specify a
specific folder, or array of folders, as test path.

```ruby
guard 'xctool-test', :test_paths => 'YourAppTests' do
  watch(%r{YourApp/(.+)\.(m|mm)$})
  watch(%r{YourAppTests/(.+)\.(m|mm)$})
end
```

```ruby
guard 'xctool-test', :test_paths => ['YourAppUITests', 'YourAppTests'] do
  watch(%r{YourApp/(.+)\.(m|mm)$})
  watch(%r{YourAppTests/(.+)\.(m|mm)$})
end
```

You can pass any of the standard xctool CLI options using the ```:cli``` option:

```ruby
guard 'xctool-test', :cli => '-workspace A.workspace' do
  watch(%r{YourApp/(.+)\.(m|mm)$})
  watch(%r{YourAppTests/(.+)\.(m|mm)$})
end
```

You might specify the full path to the xctool with ```:xctool```  option:

```ruby
guard 'xctool-test', :xctool => '/usr/local/bin/xctool' do
  watch(%r{YourApp/(.+)\.(m|mm)$})
  watch(%r{YourAppTests/(.+)\.(m|mm)$})
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
