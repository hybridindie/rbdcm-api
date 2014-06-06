# Dell Cloud Manager API Ruby Wrapper

This is an early look at the Ruby wrapper for the Dell Cloud Manager API. In due time there will be near full API coverage

At this time the only thing that can be done is creating a client ready for the request. 

I have a simple GET request in place that you can pass the resource to but I provide it without warranty; this is a fast moving project at the start and contributions are welcome. 

## Installation

Add this line to your application's Gemfile:

    gem 'rbdcm-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbdcm-api

## Usage

Only Client creating is supported as of now. It's up to you to implement the HTTP requests if you choose to use this for the time being.

```ruby
> client = DCM::Client.new(access_key: 'key', secret_key: '123')
=> #<DCM::Client:0x54fad185
 @access_key="abc",
 @api_version="2013-03-13",
 @endpoint="https://api.enstratus.com/api/enstratus",
 @method="GET",
 @secret_key="123",
 @user_agent="Dell Cloud Manager Ruby Client 0.0.1">
```

Reasonable defaults are available and only access_key and secret_key are not provided. Any can be modified at creation or runtime.

```ruby
> client.access_key = 'yek'
=> "yek"
```

If using this to augment existing software such as a Rails / Sinatra app the configuration options can also be set in a block with an initializer or custom class.
```ruby
DCM.configure do |config|
    config.access_key = '1234'
    config.secret_key = '4321'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If it's not covered by rspec tests i will reject it
