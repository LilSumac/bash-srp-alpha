local BASH = BASH;

/*
**  BASH.GetMultiInvWeight
**  Recursively gets the total weight of a storage item,
**	including any storage items within it. The first recursive
**	method I ever wrote with real world application. :^)
**		itemTab: Table of the inventory to be calculated.
**  returns: number
*/
function BASH:GetMultiInvWeight(itemTab)
	if !itemTab or !itemTab.ID then
		return 0;
	end

	if !itemTab.Inventory or !itemTab.Inventory.Content then
		return self.Items[itemTab.ID].Weight * (itemTab.Stacks or 1);
	end

	local recur_weight = 0;
	for invY = 1, #itemTab.Inventory.Content[1] do
		for invX = 1, #itemTab.Inventory.Content do
			recur_weight = recur_weight + self:GetMultiInvWeight(itemTab.Inventory.Content[invX][invY]);
		end
	end

	recur_weight = recur_weight + self.Items[itemTab.ID].Weight;
	return recur_weight;
end
