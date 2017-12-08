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
bank.exchange_with(Money.new(100_000_000,'BTC'), 'IOT')

# Set default bank to allow auto currency conversion
Money.default_bank = bank
Money.new(100_000_000,'BTC').exchange_to('IOT')
```

Cryptocompare offers some options, such as using specific exchange for rate lookup. This can be set when initializing the bank:

```ruby
Money::Bank::Cryptocompare.new(options: {'e' => 'Kraken'})
```

A list of supported exchanges are listed [here](https://github.com/alexanderdavidpan/cryptocompare#supported-exchanges).

If we want to set a rates store, pass it with the `:rates_store` key (different to standard bank method signature):

```ruby
Money::Bank::Cryptocompare.new(rates_store: rates_store)
```