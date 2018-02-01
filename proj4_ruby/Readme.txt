Ali San Kaya
Bugra Kalayci
CS 342 Project 4 Anthill Readme

We have 3 different algorithms which are as following
	- Growth -> Algorithm prioritizes builder generate to reach max rooms
	- Economy -> prioritizes forager generate
	- Aggressive -> priotizes warrior generation

If an ant enters enemy anthill teritories It has 1/10 chance to destroy that anthill

Used the builder pattern with queen object to set each parameter to the anthill object
meanwhile returning itself each time to prepare for the next configuration.

We also used object runtime conf to override the empty execute function with new behaviour depending on the ant type

Our dead ants are most of the time still around but thye wont be displayed or be able to interact with other ants thanks to
if ant alive checks

We iterate through the whole array every turn make builders do their acts if necessary then it goes on as foragers and warriors
