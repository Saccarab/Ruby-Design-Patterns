require './universe.rb'
require './probe.rb'

def main
	kappa = Universe.new(2**10)
	puts kappa.printUniverse
	puts "\n=========="
	probe = Probe.new(kappa.univ)
	probe.search

end
main()