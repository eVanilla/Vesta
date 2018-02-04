
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vesta/version"

Gem::Specification.new do |spec|
  spec.name          = "vesta-chat"
  spec.version       = Vesta::VERSION
  spec.authors       = ["eVanilla"]
  spec.email         = ["evoke.lektrique@gmail.com"]

  spec.summary       = %q{Secure decentralized chat groups via ruby!}
  spec.description   = %q{A decentralized p2p & E2EE chat group}
  spec.homepage      = "http://github.com/eVanilla/vesta"

  spec.files         = Dir['lib/**/*']
  spec.executables   = ["vesta"]  
  spec.require_paths = ['lib']
  
  spec.add_development_dependency 'bundler', '~> 1.15'

  spec.add_dependency 'activesupport', '~> 5.1', '>= 5.1.4'
  spec.add_dependency 'colorize', '~> 0.8.1'
  spec.add_dependency 'thin', '~> 1.7', '>= 1.7.2'
  spec.add_dependency 'json', '~> 2.1'
  spec.add_dependency 'sinatra', '~> 2.0'
  spec.add_dependency 'encryption', '~> 1.1', '>= 1.1.8'

end
