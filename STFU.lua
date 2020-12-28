-- Current version of STFU.
version = "1.0.0"

-- By default, block talking heads in Shadowlands dungeons.
BLOCKLIST_DEFAULT = {
  "De Other Side",
  "Halls of Atonement",
  "Mists of Tirna Scithe",
  "Plaguefall",
  "Sanguine Depths",
  "Spires of Ascension",
  "The Necrotic Wake",
  "Theater of Pain"
}

-- Initialize config variables if they are not saved.
if ENABLED == nil then
	ENABLED = 1
end

if VERBOSE == nil then
	VERBOSE = 1
end

if BLOCKLIST == nil then
	BLOCKLIST = BLOCKLIST_DEFAULT
end

-- Create the frame.
local f = CreateFrame("Frame")

-- Main function.
function f:OnEvent(event, addon)
	-- Check if the talkinghead addon is being loaded.
	if addon == "Blizzard_TalkingHeadUI" then
		hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
			-- Only run this logic if the functionality is turned on.
			if ENABLED == 1 then
        -- Query current zone and subzone when talking head is triggered.
        zoneName = GetZoneText();
        subZoneName = GetSubZoneText();
				-- Block the talking head if it's in the blocklist.
				if has_values(BLOCKLIST, zoneName, subZoneName) then
					-- Close the talking head.
					TalkingHeadFrame_CloseImmediately()
					if VERBOSE == 1 then
						print("[STFU] Blocked a talking head! Type `/stfu verbose` to turn this alert off.")
					end
				end
			end
		end)
	self:UnregisterEvent(event)
	end
end

function removeFirst(tbl, val)
	for i, v in ipairs(tbl) do
		if v == val then
			return table.remove(tbl, i)
		end
	end
end

-- Function to check if a value is in an array.
function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Function to check if either of two values is in an array.
function has_values (tab, val1, val2)
	for index, value in ipairs(tab) do
		if value == val1 or value == val2 then
			return true
		end
	end
	return false
end

-- Slash command function.
function MyAddonCommands(args)
	if args == "on" or args == "enable" then
		ENABLED = 1
		print("[STFU] Enabled! Talking heads will be blocked in blocklisted zones.")
	elseif args == "off" or args == "disable" then
		ENABLED = 0
		print("[STFU] Disabled! All talking heads will now be allowed.")
	elseif args == "toggle zone" then
		zone = GetZoneText()
		if has_value(BLOCKLIST, zone) then
			removeFirst(BLOCKLIST, zone)
			print("[STFU] " .. zone .. " removed from the blocklist.")
		else
			table.insert(BLOCKLIST, zone)
			print("[STFU] " .. zone .. " added to the blocklist.")
		end
	elseif args == "toggle subzone" then
		zone = GetSubZoneText()
		if has_value(BLOCKLIST, zone) then
			removeFirst(BLOCKLIST, zone)
			print("[STFU] " .. zone .. " removed from the blocklist.")
		else
			table.insert(BLOCKLIST, zone)
			print("[STFU] " .. zone .. " added to the blocklist.")
		end
	elseif args == "toggle" then
		print("[STFU] Usage: `/stfu toggle zone` to add or remove the current zone (e.g. Orgrimmar) from the blocklist. `/stfu toggle subzone` to add or remove the current subzone (e.g. Valley of Strength) from the blocklist.")
	elseif args == "list" then
    if next(BLOCKLIST) == nil then
      print("[STFU] The blocklist is currently empty.")
    else
      print("[STFU] Zones and subzones where talking heads will be blocked: " .. table.concat(BLOCKLIST, ", "))
    end
	elseif args == "reset" then
		BLOCKLIST = BLOCKLIST_DEFAULT
		print("[STFU] Blocklist has been reset to the default list, which is all Shadowlands dungeons.")
	elseif args == "clear" then
		BLOCKLIST = {}
		print("[STFU] Blocklist has been completely cleared.")
	elseif args == "verbose" then
		if VERBOSE == 0 then
			VERBOSE = 1
			print("[STFU] Verbose mode enabled. Chat messages will appear when talking heads are blocked.")
		elseif VERBOSE == 1 then
			VERBOSE = 0
			print("[STFU] Verbose mode disabled. Chat messages will not appear when talking heads are blocked.")
		end
  else
		print("[STFU] AddOn version " .. version)
    if ENABLED == 1 then
      print("[STFU] The addon is currently enabled.")
    else
      print("[STFU] The addon is currently disabled.")
    end
    if VERBOSE == 1 then
      print("[STFU] Verbose logging is enabled.")
    else
      print("[STFU] Verbose logging is disabled.")
    end
    print("[STFU] -----")
		print("[STFU] Available subcommands for the `/stfu` slash command:")
    print("[STFU] `on` or `enable`: Enables STFU, allowing it to block talking heads.")
    print("[STFU] `off` or `disable`: disables STFU, preventing it from blocking talking heads.")
    print("[STFU] `toggle zone`: Toggles the inclusion of the current zone (e.g. Orgrimmar) in STFU's blocklist.")
    print("[STFU] `toggle subzone`: Toggles the inclusion of the current subzone (e.g. Valley of Strength) in STFU's blocklist.")
    print("[STFU] `list`: Prints a list of all the zones and subzones on the blocklist to the chat.")
    print("[STFU] `reset`: Sets the blocklist back to its default value, which is all Shadowlands dungeons.")
    print("[STFU] `clear`: Completely clears the blocklist, removing all zones and subzones.")
    print("[STFU] `verbose`: Toggles verbose logging. When on, messages will be printed to the main chat frame when talking heads are blocked.")
	end
end

-- Add /stfu to slash command list and register its function.
SLASH_STFU1 = "/stfu"
SlashCmdList["STFU"] = MyAddonCommands

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)
