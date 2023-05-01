
local PLUGIN = PLUGIN

PLUGIN.name = "Genecoded Guns"
PLUGIN.author = "Ron"
PLUGIN.description = "Adds a gun genecoding system tied to flags."
PLUGIN.schema = "HL2RP"
PLUGIN.license = [[
Copyright 2023 Ron
This work is licensed under the MIT License.
To view a copy of this license, visit https://opensource.org/licenses/MIT.
]]

ix.flag.Add("G", "Access to genecoded weapons.")

ix.lang.AddTable("english", {
	cantUse = "The gun doesn't respond to your attempts at using it.",
})

function PLUGIN:CanUseGun(client)
	local character = client:GetCharacter()
	if(!character) then
		return false
	end

	if(character:HasFlags("G")) then
		return true
	end

	return false
end

function PLUGIN:CanPlayerEquipItem(client, item)
    if(item.geneCoded and !PLUGIN:CanUseGun(client)) then
		client:EmitSound("buttons/combine_button_locked.wav")
        client:NotifyLocalized("cantUse")
        return false
	end
end

