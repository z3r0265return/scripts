local results = {}
print("---- Beta Unc Test ---- @z3r0265")

local function test(name, func)
	local success, result = pcall(func)
	results[name] = success and "✅" or ("❌ - " .. tostring(result))
end

test("writefile", function() return writefile("unc_test.txt", "hello") end)
test("readfile", function() return readfile("unc_test.txt") end)
test("delfile", function() return delfile("unc_test.txt") end)
test("isfile", function() return isfile("unc_test.txt") end)
test("saveinstance", function() return saveinstance() end)
test("getconnections", function() return getconnections(game.DescendantAdded) end)
test("getsenv", function() return getsenv(game.Players.LocalPlayer) end)
test("getgenv", function() return getgenv() end)
test("setreadonly", function() return setreadonly({}, false) end)
test("getrenv", function() return getrenv() end)
test("getgc", function() return getgc(true) end)
test("httpget", function() return (http and http.get) and http.get("https://google.com") or HttpGet("https://google.com") end)
test("httppost", function() return (http and http.post) and http.post("https://google.com", "") or HttpPost("https://google.com", "") end)
test("hookfunction", function()
	local f = function() return "test" end
	local h = hookfunction or hook_function or function() error("no hookfunction") end
	local success, _ = pcall(function()
		h(f, function() return "hooked" end)
	end)
	return success
end)
test("firetouchinterest", function()
	return firetouchinterest and firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Baseplate, 0)
end)
test("setclipboard", function()
	return setclipboard and setclipboard("test")
end)

for name, status in pairs(results) do
	print(name .. ": " .. status)
end
