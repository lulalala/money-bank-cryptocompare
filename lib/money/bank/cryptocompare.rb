require "money"
require "cryptocompare"

class Money
  module Bank
    class Cryptocompare < VariableExchange
      def initialize(rates_store: nil, options: {}, &block)
        @cyptocompare_options = options

        rates_store ||= Money::RatesStore::Memory.new
        super(rates_store, &block)
      end

      def get_rate(from, to, opts = {})
        rate = super

        if rate
          rate
        else
          # Fetch exchange rate
          info = ::Cryptocompare::Price.find(from, to, @cyptocompare_options)
          if info["Response"] == "Error"
            return nil
          end
          add_rate(from, to, info[from.to_s][to.to_s])
        end
      end
    end
  end
end
