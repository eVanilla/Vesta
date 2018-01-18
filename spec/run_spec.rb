lib = File.expand_path("../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vesta"

describe Vesta do
	context "When testing the Vesta class" do 
		it "should work" do 
			Vesta::Service
		end
	end
end