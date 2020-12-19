class "VehicleRestrictorTimer"
local currentTime = 0
local lastDelta = 0
local timers = {}

function VehicleRestrictorTimer:__init()

	Events:Subscribe('UpdateManager:Update', self, self.OnEngineUpdate)
end



function VehicleRestrictorTimer:GetTimers()
	return timers
end

function VehicleRestrictorTimer:GetTimer(timerName)
	if not timerName then
		print('GetTimer() - argument timerName was nil')
		return
	end

	return timers[timerName]
end

function VehicleRestrictorTimer:OnEngineUpdate(p_Delta, updatePass)
	if updatePass ~= 0 then -- only on PreSim
		return
	end
	lastDelta = lastDelta + p_Delta
	currentTime = currentTime + lastDelta
	lastDelta = 0

	VehicleRestrictorTimer:Check()
end


function VehicleRestrictorTimer:CreateDelay(name, delay, func)
	return VehicleRestrictorTimer:CreateInternal(name, delay, 1, func, false)
end

function VehicleRestrictorTimer:CreateInterval(name, delay, interval, func)
	return VehicleRestrictorTimer:CreateInternal(name, delay, 0, func, true, interval)
end

function VehicleRestrictorTimer:CreateInternal(name, delay, reps, func, isRepetitive, interval) -- call one of the above not this one
	if timers[name] ~= nil then
		return false -- check if timer for that player already exists
	end
	
	
	if name ~= nil and type(name) ~= "string" then
		print("Invalid timer name: "..tostring(name))
		return false
	end

	if type(delay) ~= "number" or delay < 0 then
		print("Invalid timer delay: "..tostring(delay))
		return false
	end

	if type(reps) ~= "number" or reps < 0 or math.floor(reps) ~= reps then
		print("Invalid timer reps: "..tostring(reps))
		return false
	end

	if type(func) ~= "function" and not (getmetatable(func) and getmetatable(func).__call) then
		print("Invalid timer function: "..tostring(func))
		return false
	end

	if interval == 0 or interval == nil then
		interval = delay
		end

	timers[name] = {
		name = name,
		delay = delay,
		reps = reps == 0 and -1 or reps,
		func = func,
		on = false,
		lastExec = 0,
		isRepetitive = false or isRepetitive,
		interval = interval
	}

	print("timer name: " .. name .. ' delay: ' .. delay)
	VehicleRestrictorTimer:Start(name)
	return true
end

function VehicleRestrictorTimer:Check()
	local t = currentTime
	for name,tmr in pairs(timers) do
		if tmr.lastExec + tmr.delay <= t and tmr.on then
			tmr.func()

			tmr.lastExec = t

			if not tmr.isRepetitive then
				tmr.reps = tmr.reps - 1
				if tmr.reps == 0 then
					timers[name] = nil
					print("removed timer " .. tmr.name)
				end
			else
				tmr.delay = interval
			end
		end
	end
end

function VehicleRestrictorTimer:Start(name)
	print('Starting timer: ' .. name)
	local t = timers[name]
	if not t then
		print("Tried to start nonexistant timer: "..tostring(name))
		return
	end
	t.on = true
	t.timeDiff = nil
	t.lastExec = currentTime
	return true
end


function VehicleRestrictorTimer:Delete(name)
	if name == nil or type(name) ~= "string" then
		return
	end

	if timers[name] ~= nil then
		print('Delete timer: ' .. name)
		timers[name] = nil
	end
	
end


-- Singleton.
if g_VehicleRestrictorTimer == nil then
    g_VehicleRestrictorTimer = VehicleRestrictorTimer()
end

return g_VehicleRestrictorTimer
