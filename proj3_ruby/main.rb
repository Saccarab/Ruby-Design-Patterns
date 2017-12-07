require_relative('battlenet.rb')
require_relative('raider_io.rb')
require_relative('warcraftlogs.rb')
require_relative('log.rb')
require_relative('cache.rb')
require 'open-uri'
require 'json'


def main	
	log = Log.instance
	cache = Cache.instance
	obj = Battlenet.new('twisting nether','kasady', log, cache, Raider_io.new('kazzak','sanktorah', Warcraftlogs.new('kazzak','lazelina')))
	log.closeFile
	cache.closeFile
end

main()