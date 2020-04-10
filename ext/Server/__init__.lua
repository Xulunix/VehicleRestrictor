require "Settings"
require "Enums"
require "Vehicles"

function shortVehicleName(longName)
	return longName:gsub(".+/.+/","")
end


class 'vehicleRestrictor'

function vehicleRestrictor:__init()
	print("Initializing VehicleRestrictor")
	self:RegisterVars()
	self:RegisterHooks()
	self:RegisterEvents()
	print("Initialized VehicleRestrictor")
end


function vehicleRestrictor:RegisterVars()
end


function vehicleRestrictor:RegisterHooks()
		Hooks:Install("Soldier:Damage", 999, self, self.OnPlayerDamage)
		Hooks:Install("Vehicle:Damage", 999, self, self.OnVehicleDamageHook)
	
end

function vehicleRestrictor:RegisterEvents()
	Events:Subscribe("Vehicle:Enter", self, self.OnEnterVehicle)
	Events:Subscribe("Vehicle:Exit", self, self.OnExitVehicle)
	Events:Subscribe("Vehicle:Damage", self, self.OnDamageVehicle)
end


function vehicleRestrictor:OnEnterVehicle(vehicle, player)
	if Settings.DEBUG_LEVEL >= 2 then
		print("EnterVehicle Type: " .. vehicle.typeInfo.name)
	end
	
	local cVehicleData = VehicleEntityData(vehicle.data)
	local vehicleName = shortVehicleName(cVehicleData.controllableType)
	if Settings.DEBUG_LEVEL >= 1 then
		print("Player " .. player.name .. " (".. TeamNames[player.teamId] .. ") entered vehicle " .. vehicleName .. " (".. TeamNames[Vehicles[vehicleName].Team] .."|".. VehicleTypes[Vehicles[vehicleName].Type] ..")")
	end
	if Settings.TRIGGER == 1 and Vehicles[vehicleName].Team ~= 0 and Vehicles[vehicleName].Team ~= player.teamId then	
		vehicleRestrictor:handleSteal(player, vehicle)
	end
end

function vehicleRestrictor:OnExitVehicle(vehicle, player)
	if Settings.DEBUG_LEVEL >= 2 then
		print("ExitVehicle Type: " .. vehicle.typeInfo.name)
	end
	
	local cVehicleData = VehicleEntityData(vehicle.data)
	local vehicleName = shortVehicleName(cVehicleData.controllableType)
	if Settings.DEBUG_LEVEL >= 1 then
		print("Player " .. player.name .. " (".. TeamNames[player.teamId] .. ") left vehicle " .. vehicleName .. " (".. TeamNames[Vehicles[vehicleName].Team] .."|".. VehicleTypes[Vehicles[vehicleName].Type] ..")")
	end
end

-- Event when vehicle health changes
function vehicleRestrictor:OnDamageVehicle(vehicle, damage)
	if damage < 0 then -- negative damage = repair
		return
	end
	local cVehicleData = VehicleEntityData(vehicle.data)
	-- print("Damaged Vehicle ".. cVehicleData.controllableType .. ": " .. damage)

end

function vehicleRestrictor:OnVehicleDamageHook(hook, vehicle, giver)
	print("vehicle damage hook")
end

-- hook gets called when soldier HP changes
function vehicleRestrictor:OnPlayerDamage(hook, soldier, info, giverInfo)
	if info.damage < 0 or soldier.player == nil then -- negative damage = heal or player already dead
		return
	end
	
	local giverName = "world" 
	if giverInfo.giver ~= nil then -- If giver not set, damage source is world
		giverName = giverInfo.giver.name
	end
		
	local cGiverInfo = DamageGiverInfo(giverInfo)
	local sourceVehicle = ""
	
	if cGiverInfo.giverControllable ~= nil then -- check if damage source is controllable
		if Settings.DEBUG_LEVEL >= 2 then
			print("cGiverInfo.giverControllable: " .. Entity(cGiverInfo.giverControllable).typeInfo.name)
		end
		
		if Entity(cGiverInfo.giverControllable).typeInfo.name == "ServerVehicleEntity" then -- check if damage source is a vehicle
			local controllableVehicle = VehicleEntityData(cGiverInfo.giverControllable.data) 
			sourceVehicle = " using vehicle " .. shortVehicleName(controllableVehicle.controllableType)
		end
	end
	if Settings.DEBUG_LEVEL >= 2 then
		print("Damaged Player " .. soldier.player.name .. " with " .. info.damage .. " by " .. giverName .. sourceVehicle) 
	end
end

function vehicleRestrictor:handleSteal(player, vehicle)
	if Settings.DEBUG_LEVEL >= 2 then
		print("HandleSteal VehicleType: " .. vehicle.typeInfo.name)
		--print("HandleSteal PlayerType: " .. player.typeInfo.name)
	end

	local cVehicleData = VehicleEntityData(vehicle.data)
	local vehicleName = shortVehicleName(cVehicleData.controllableType)
	if Settings.DEBUG_LEVEL >= 1 then
		print("Player " .. player.name .. " stole vehicle " .. vehicleName) 
	end
	
	-- Kill Player
	if Settings.PUNISHMENT_TYPE == 1 then
		local soldier = SoldierEntity(player.soldier)
		soldier:Kill()
		print("Killed player " .. player.name .. " for stealing vehicle (" ..vehicleName .. ")")
		ChatManager:SendMessage("Killed " .. player.name .. " for stealing a vehicle")
	end
	
	-- Destroy Vehicle (and player in it)
	if Settings.PUNISHMENT_TYPE == 2 then
		vehicle:FireEvent("Destroy")
		if vehicle ~= nil then
			vehicle:Destroy()
		end
		if player.hasSoldier and player.soldier ~= nil then
			player.soldier:Kill()
		end
		print("Killed player " .. player.name .. " for stealing vehicle (" ..vehicleName .. "), destroyed vehicle")
		ChatManager:SendMessage("Killed " .. player.name .. " for stealing a vehicle")
	end
	
end


g_vehicleRestrictor = vehicleRestrictor()

