lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "money-bank-cryptocompare"
  spec.version       = "0.1.0"
  spec.license       = 'MIT'
  spec.authors       = ["lulalala"]
  spec.email         = ["mark@goodlife.tw"]

  spec.summary       = %q{Money Bank for fetch cryptocurrency exchange rates from Cryptocompare}
  spec.description   = %q{Money gem's Bank implementation to Cryptocompare API to do cryptocurrency exchange, like converting Bitcoin to Ethereum.}
  spec.homepage      = "https://github.com/lulalala/money-bank-cryptocompare"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'money'
  spec.add_dependency 'cryptocompare'

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7.0"
end
