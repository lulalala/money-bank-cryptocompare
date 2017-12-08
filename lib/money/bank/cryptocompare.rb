require "money"
require "cryptocompare"

class Money
  module Bank
    class Cryptocompare < VariableExchange
      def get_rate(from, to, opts = {})
        rate = super

        if rate
          rate
        else
          # Fetch exchange rate
          info = ::Cryptocompare::Price.find(from, to)
          if info["Response"] == "Error"
            return nil
          end
          add_rate(from, to, info[from.to_s][to.to_s])
        end
      end
    end
  end
end
