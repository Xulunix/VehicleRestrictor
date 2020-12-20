Settings = {
	-- ### Print debug messages to server console ###
	-- 0 = Only print actions taken
	-- 1 = Info
	-- 2 = Debug
	DEBUG_LEVEL = 2,

	-- ### Punishment type ###
	-- 0 = Disabled
	-- 1 = Kill player
	-- 2 = Kill player & destroy vehicle
	-- 3 = Damage player over time
	-- 4 = Damage vehicle over time
	PUNISHMENT_TYPE = 3,
	
	-- ### Punishment trigger ###
	-- 1 = Entering vehicle
	-- 2 = Damaging enemy vehicle or player with a stolen vehicle
	TRIGGER  = 1,
	
	-- ### Punishment delay after trigger (in seconds) ###
	-- If player leaves the vehicle before the delay is over, no action will be taken
	DELAY = 1.0,
	
	-- ### Punishment interval (in seconds) ###
	-- Applies damage every X seconds. Only used with PUNISHMENT_TYPE = 3/4
	INTERVAL = 1.0,
	
	-- ### Amount of damage applied each interval (in %) ###
	-- 50 = half HP per tick 
	DAMAGE = 15,
	
	-- ### Show warning to player? ###
	-- only used if DELAY > 0
	SHOW_WARNING = true,

	-- ### Show in chat that a player was killed/Punished
	ANNOUNCE_IN_CHAT = true,
}