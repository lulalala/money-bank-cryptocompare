# Money::Bank::Cryptocompare

Money gem's Bank implementation to Cryptocompare API to do cryptocurrency exchange, like converting Bitcoin to Ethereum.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'money-bank-cryptocompare'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install money-bank-cryptocompare

## Usage

First you need to define the cryptocurrency you need:

```ruby
require 'money'

curr = {
  :priority            => 1,
  :iso_code            => "IOT",
  :name                => "IOT",
  :subunit             => "IOT",
  :subunit_to_unit     => 1,
}
Money::Currency.register(curr)
```

Initialize the bank, and call `exchange_to` as you normally would.

```ruby
require 'money/bank/cryptocompare'

bank = Money::Bank::Cryptocompare.new
Money.default_bank = bank

b = Money.new(100_000_000,'BTC')
b.exchange_to('IOT')
```