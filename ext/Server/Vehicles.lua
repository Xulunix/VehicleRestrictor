-- ### Vehicle configuration
-- # Team value describes who is allowed to use a vehicle
--   -1 = Noone is allowed to use it
--   0 = Vehicle is neutral, everyone can use it
--   1 to 16 (1 is US; 2 is RU, other nubers are squads for SQDM)
-- Default configuration is to prevent players using ANY enemy vehicles, except transport jeeps
-- Depending on map and gamemode, you might want to allow Tanks or other vehicles to be used by both teams
Vehicles = { 
	-- US Vehicles
	["AH1Z"] = {Team=1}, -- US attack heli
	["Venom"] = {Team=1}, -- US transport heli
	["Centurion_C-RAM"] = {Team=1}, -- US Stationary AA
	["F16"] = {Team=1}, -- US default jet
	["LAV_AD"] = {Team=1}, -- US Mobile AA 
	["M1Abrams"] = {Team=1},  -- US Tank
	["AAV-7A1"] = {Team=1}, -- AAV-7A1 AMTRAC transport tank
	["M1126-Stryker"] = {Team=1}, -- US Tank destroyer
	["MIMARS"] = {Team=1}, -- US Mobile artillery
	["F35B"] = {Team=1}, -- US F35 hover jet
	["A10_THUNDERBOLT"] = {Team=1}, -- US CAS jet
	["AH6_Littlebird"] = {Team=1}, -- US Scout heli
	["LAV25"] = {Team=1}, -- US IFV
	["LAV25_Paradrop"] = {Team=1}, -- US IFV (Dropped from Dropship)
	["Humvee_ASRAD"] = {Team=1}, -- US AA humvee
	["HumveeArmored"] = {Team=1}, -- US humvee with .50cal MG
	["HumveeModified"] = {Team=1}, -- 'PHOENIX' modified HUMVEE
	["GrowlerITV"] = {Team=0}, -- US jeep, set as neutral because spawns outside of base
	["DPV"] = {Team=0}, -- DPV Buggy, set as neutral because spawns outside of base

	-- RU Vehicles
	["Su-35BM Flanker-E"] = {Team=2}, -- RU default jet
	["T90"] = {Team=2}, -- RU Tank
	["Mi28"] = {Team=2},  -- RU attack heli
	["Ka-60"] = {Team=2}, -- RU Transport heli
	["Pantsir-S1"] = {Team=2}, -- RU Stationary AA
	["9K22_Tunguska_M"] = {Team=2}, -- RU Mobile AA
	["BMP2"] = {Team=2}, -- RU transport tank
	["2S25_SPRUT-SD"] = {Team=2}, -- RU Tank Destroyer
	["STAR_1466"] = {Team=2}, -- RU Mobile artillery
	["Su-25TM"] = {Team=2}, -- RU CAS jet
	["Z-11w"] = {Team=2}, -- RU Scout heli
	["BTR90"] = {Team=2}, -- RU IFV
	["VodnikPhoenix"] = {Team=2}, -- RU AA vehicle
	["GAZ-3937_Vodnik"] = {Team=2}, -- RU jeep with .50cal MG
	["VodnikModified_V2"] = {Team=2}, -- 'BRASUK' modified van
	["VDV Buggy"] = {Team=0}, -- RU jeep, set as neutral because spawns outside of base
	
	-- Stationary Map
	["Kornet"] = {Team=0}, -- US variant of stationary rocket launcher
	["TOW2"] = {Team=0}, -- RU variant of stationary rocket launcher
	["RHIB"] = {Team=0}, -- Boat
	["QuadBike"] = {Team=0}, -- Quad bike
	["AC130"] = {Team=0}, -- AC130 Gunship
	["C130"] = {Team=0}, -- Dropship
	["VanModified"] = {Team=0}, -- 'Rhino' modified van
	["KLR650"] = {Team=0}, -- Dirt bike
	["SkidLoader"] = {Team=0}, -- Skid loader
	
	-- Equipment
	["AGM-144_Hellfire_TV"] = {Team=0}, -- TV rocket of Attack heli
	["EODBot"] = {Team=0}, -- EodBot
	["M224"] = {Team=0}, -- Mortar
	["SOFLAM_Projectile"] = {Team=0}, -- Soflam
	["MAV"] = {Team=0}, -- Mav
	
	
}