local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_quiver";
ITEM.Name =				"Quiver";
ITEM.Description =		"An artifact similar in shape to a Gravi or Goldfish, the Quiver is named for its effect on STALKERs, namely a frigid sensation that makes them shiver and shake. These are formed within frost-based anomalies and despite making the user feel cold, they are protected from frostbite. Aside from this, the Quiver is fairly radioactive.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/spezzy/art_moldfish.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	8000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    10;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
