require 'spec_helper'
require 'money/bank/cryptocompare'

RSpec.describe Money::Bank::Cryptocompare do
  subject { Money::Bank::Cryptocompare.new }

  before do
    curr = {
      :priority            => 1,
      :iso_code            => "FOO",
      :name                => "FOO",
      :subunit             => "FOO",
      :subunit_to_unit     => 1,
    }

    Money::Currency.register(curr)

    Money.default_bank = subject
  end

  it 'returns existing rate' do
    subject.add_rate('USD', 'FOO', 0.25)
    from = Money.new(10000, 'USD')
    expect(from.exchange_to("FOO")).to eq(Money.new(25, "FOO"))
  end

  it 'raises error if rate is not present' do
    expect(::Cryptocompare::Price).to receive(:find).with(Money::Currency.new('USD'), Money::Currency.new('FOO'), {}).and_return(
      {"Response"=>"Error", "Message"=>"There is no data for any of the toSymbols FOO .", "Type"=>1, "Aggregated"=>false, "Data"=>[], "Warning"=>"There is no data for the toSymbol/s FDS ", "HasWarning"=>true}
    )

    from = Money.new(100, 'USD')
    expect {
      from.exchange_to("FOO")
    }.to raise_error(Money::Bank::UnknownRate)
  end

  it 'exchanges Money when rate is present' do
    expect(::Cryptocompare::Price).to receive(:find).with(Money::Currency.new('USD'), Money::Currency.new('FOO'), {}).and_return({"USD"=>{"FOO"=>52}})

    from = Money.new(100, 'USD')
    expect(from.exchange_to("FOO")).to eq(Money.new(52, "FOO"))
  end

  context 'with cryptocompare options' do
    let(:options) { {'e' => 'Kraken'} }
    let(:amount) { Money.new(100000) }
    subject { Money::Bank::Cryptocompare.new(options: options) }

    it 'handles exchange options' do
      expect(::Cryptocompare::Price).to receive(:find).with(Money::Currency.new('USD'), Money::Currency.new('FOO'), options).and_return({"USD"=>{"FOO"=>52}})

      subject.exchange_with(amount, "FOO")
    end
  end
end