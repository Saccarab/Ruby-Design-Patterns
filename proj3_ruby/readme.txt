I've chosen the decorater pattern so I was able to give each object(api calls in this occasion)
different functionalities since they all parse their response in different manners.
Also the encapsulation gained by decorator wrapping felt nice to use on each class.

I've also used a caching system to get some extra credit if possible.
So I have cache.rb file too and If that request has been done before it uses the cache instead of making a new request.


Three subclasses exist "raider_io.rb", "warcraftlogs.rb" and "battlenet.rb"
2 of them includes api keys aswell in their initializers.

Warcraftlogs class is the concrete component which is the end of the line for requests.

They all do the appropriate parsing before calling the getJson function on the nextObj ensuring the decorator
pattern.

Everyone of them grabs a fraction of world of warcraft character data and outputs those.

I've have an error handling block in the base class "apiproxy.rb" that grabs the socket and 
not found errors which is handled below.

Appropriate logtexts are logged in the parseJson function which is the actual decorator pattern action.