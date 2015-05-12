# A Real Pain in the RSpec

Run your RSpec tests and print out punny spec descriptions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "pain_in_the_rspec"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pain_in_the_rspec

## Usage

Run your specs like this:

    $ rspec --format PainInTheRspec::Formatter spec/

To always run your specs with PainInTheRspec, add the following line to your
`.rspec` file:

    --format PainInTheRspec::Formatter

## Pitfalls

The formatter uses a web API to get rhymes. It will therefore make a web request
for each example in your suite.

If you're using WebMock, you'll need to allow external network requests to
`rhymebrain.com`, which this gem uses:

```ruby
# To only allow rhymebrain.com
WebMock.disable_net_connect!(allow: "rhymebrain.com")
# Or, if you're already allowing example.com:
WebMock.disable_net_connect!(allow: ["example.com", "rhymebrain.com"])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git commits
and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pain_in_the_rspec/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
