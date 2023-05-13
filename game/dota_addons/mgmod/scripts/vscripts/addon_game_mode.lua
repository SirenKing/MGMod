-- Generated from template
function _G.softRequire(file)
	_G.dummyEnt = dummyEnt or Entities:CreateByClassname("info_target")
	local happy,msg = pcall(require,file)
	if not happy then
		dummyEnt:SetThink(function()
			error(msg,2)
		end)
	end
end

if CBoostedGameMode == nil then
	CBoostedGameMode = class({})
end

require("utils/timers")
require("utils/toolbox")
softRequire("plugin_system/main")

function Precache( context )
	
	local file = LoadKeyValues('scripts/vscripts/plugin_system/precache_list.txt')
    if not (file == nil or not next(file)) then
        for k,v in pairs(file) do
			PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_" .. k .. ".vsndevts", context)
		end
    end
	PrecacheResource( "particle", "particles/souls/ward_skull_rubick.vpcf", context )
end
function Activate()
	GameRules.AddonTemplate = CBoostedGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CBoostedGameMode:InitGameMode()
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	GameRules:GetGameModeEntity():SetWeatherEffectsDisabled(false)
end

function CBoostedGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end