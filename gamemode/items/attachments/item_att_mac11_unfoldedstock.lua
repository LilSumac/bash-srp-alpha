local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_mac11_unfoldedstock";
ITEM.Name =				"MAC-11 Unfolded Stock";
ITEM.Hidden =			true;
ITEM.LootHidden =       true;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Stock";
ITEM.AttachmentEnt =    "bg_mac11_unfolded_stock";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
