stonks_crb = stonks_crb or class({})



function stonks_crb:GetTexture() return "stonks" end -- get the icon from a different ability
function stonks_crb:IsPermanent() return true end
function stonks_crb:RemoveOnDeath() return false end
function stonks_crb:IsHidden() return false end
function stonks_crb:IsDebuff() return false end
function stonks_crb:AllowIllusionDuplicate() return true end

function stonks_crb:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function stonks_crb:OnCreated(event)
    if not IsServer() then return end
    if (event.stack ~= nil) then
        local total = event.stack
        if (total == 0) then
            self:SetStackCount(0)
            self:GetParent():CalculateStatBonus(true)
            self:GetParent():CalculateGenericBonuses()
            self:Destroy()
        else
            self:SetStackCount(total)
            self:GetParent():CalculateStatBonus(true)
            self:GetParent():CalculateGenericBonuses()
        end
    end
    if self:GetParent():IsIllusion() then
        self:SetStackCount(self:GetParent():GetPlayerOwner():GetAssignedHero():FindModifierByName(self:GetName()):GetStackCount())
    end
end

function stonks_crb:OnRefresh(event)
    if not IsServer() then return end
    if (event.stack ~= nil) then
        local total = event.stack + self:GetStackCount()
        if (total == 0) then
            self:SetStackCount(0)
            self:GetParent():CalculateStatBonus(true)
            self:GetParent():CalculateGenericBonuses()
            self:Destroy()
        else
            self:SetStackCount(total)
            self:GetParent():CalculateStatBonus(true)
            self:GetParent():CalculateGenericBonuses()
        end
    end
end 

function stonks_crb:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	}
	return funcs
end

function stonks_crb:GetModifierCastRangeBonusStacking()
    return self:GetStackCount()*5
end