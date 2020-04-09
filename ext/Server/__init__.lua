require 'Enums'
require 'Vehicles'

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
	Events:Subscribe("Vehicle:Damage", self, self.OnDamageVehicle)
end


function vehicleRestrictor:OnEnterVehicle(vehicle, player)
	print("EnterVehicle Type: " .. vehicle.typeInfo.name)
	local cVehicleData = VehicleEntityData(vehicle.data)
	local vehicleName = shortVehicleName(cVehicleData.controllableType)
	print("Player " .. player.name .. " (".. TeamNames[player.teamId] .. ") entered vehicle " .. vehicleName .. " (".. TeamNames[Vehicles[vehicleName].Team] .." | ".. VehicleTypes[Vehicles[vehicleName].Type] ..")")
end

-- Event when vehicle health changes
function vehicleRestrictor:OnDamageVehicle(vehicle, damage)
	if damage < 0 then -- negative damage = repair
		return
	end
	local cVehicleData = VehicleEntityData(vehicle.data)
	--print("Damaged Vehicle ".. cVehicleData.controllableType .. ": " .. damage)

end

function vehicleRestrictor:OnVehicleDamageHook(hook, vehicle, giver)
	print("vehicle damage hook")
end

-- hook gets called when soldier HP changes
function vehicleRestrictor:OnPlayerDamage(hook, soldier, info, giverInfo)
	if info.damage < 0 then -- negative damage = heal
		return
	end
	
	local giverName = "world" 
	if giverInfo.giver ~= nil then -- If giver not set, damage source is world
		giverName = giverInfo.giver.name
	end
		
	local cGiverInfo = DamageGiverInfo(giverInfo)
	local sourceVehicle = ""
	
	if cGiverInfo.giverControllable ~= nil then -- check if damage source is controllable
		print("cGiverInfo.giverControllable: " .. Entity(cGiverInfo.giverControllable).typeInfo.name)
		if Entity(cGiverInfo.giverControllable).typeInfo.name == "ServerVehicleEntity" then -- check if damage source is a vehicle
			local controllableVehicle = VehicleEntityData(cGiverInfo.giverControllable.data) 
			sourceVehicle = " using vehicle " .. shortVehicleName(controllableVehicle.controllableType)
		end
	end

	print("Damaged Player " .. soldier.player.name .. " with " .. info.damage .. " by " .. giverName .. sourceVehicle) 
end



g_vehicleRestrictor = vehicleRestrictor()

