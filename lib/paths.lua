local abilityID = 1346
local passivesID = 515
return
{
	assets = {
		unsorted = {
			ability = "./unpacked/DefineSprite_" .. abilityID .. "_AbilityIcon",
			passive = "./unpacked/DefineSprite_" .. passivesID .. "_PassiveIcon",
		},
		final = {
			ability = "./unpacked/abilityIcons",
			passive = "./unpacked/passiveIcons",
		},
		swf = {
			ability = "./mewgenics-data/swfs/ability_icons.swf"
		}
	},
	data = {
		json = {
			folder = "./unpacked",
			passives = "./unpacked/passives.json",
			abilities = "./unpacked/abilities.json",
		},
		csv = {
			"./mewgenics-data/data/text/abilities.csv",
			"./mewgenics-data/data/text/additions2.csv",
			"./mewgenics-data/data/text/additions3.csv",
			"./mewgenics-data/data/text/additions.csv",
			"./mewgenics-data/data/text/cutscene_text.csv",
			"./mewgenics-data/data/text/enemy_abilities.csv",
			"./mewgenics-data/data/text/events.csv",
			"./mewgenics-data/data/text/furniture.csv",
			"./mewgenics-data/data/text/items.csv",
			"./mewgenics-data/data/text/keyword_tooltips.csv",
			"./mewgenics-data/data/text/misc.csv",
			"./mewgenics-data/data/text/mutations.csv",
			"./mewgenics-data/data/text/npc_dialog.csv",
			"./mewgenics-data/data/text/passives.csv",
			"./mewgenics-data/data/text/progression.csv",
			"./mewgenics-data/data/text/pronouns.csv",
			"./mewgenics-data/data/text/teamnames.csv",
			"./mewgenics-data/data/text/units.csv",
			"./mewgenics-data/data/text/weather.csv",
		},
		gon = {
			passives = {
				"./mewgenics-data/data/passives/butcher_passives.gon",
				"./mewgenics-data/data/passives/colorless_passives.gon",
				"./mewgenics-data/data/passives/disorders.gon",
				"./mewgenics-data/data/passives/druid_passives.gon",
				"./mewgenics-data/data/passives/fighter_passives.gon",
				"./mewgenics-data/data/passives/hunter_passives.gon",
				"./mewgenics-data/data/passives/jester_passives.gon",
				"./mewgenics-data/data/passives/mage_passives.gon",
				"./mewgenics-data/data/passives/medic_passives.gon",
				"./mewgenics-data/data/passives/monk_passives.gon",
				"./mewgenics-data/data/passives/necromancer_passives.gon",
				"./mewgenics-data/data/passives/psychic_passives.gon",
				"./mewgenics-data/data/passives/tank_passives.gon",
				"./mewgenics-data/data/passives/thief_passives.gon",
				"./mewgenics-data/data/passives/tinkerer_passives.gon",
				"./mewgenics-data/data/passives/util_passives.gon",
			},
			abilities = {
				"./mewgenics-data/data/abilities/abilities.gon",
				"./mewgenics-data/data/abilities/armor_abilities.gon",
				"./mewgenics-data/data/abilities/basic_attacks.gon",
				"./mewgenics-data/data/abilities/basic_movement.gon",
				"./mewgenics-data/data/abilities/butcher_abilities.gon",
				"./mewgenics-data/data/abilities/colorless_abilities.gon",
				"./mewgenics-data/data/abilities/consumable_item_abilities.gon",
				"./mewgenics-data/data/abilities/contextual_abilities.gon",
				"./mewgenics-data/data/abilities/disorder_abilities.gon",
				"./mewgenics-data/data/abilities/druid_abilities.gon",
				"./mewgenics-data/data/abilities/event_abilities.gon",
				"./mewgenics-data/data/abilities/fighter_abilities.gon",
				"./mewgenics-data/data/abilities/finalboss_abilities.gon",
				"./mewgenics-data/data/abilities/guillotina_abilities.gon",
				"./mewgenics-data/data/abilities/hunter_abilities.gon",
				"./mewgenics-data/data/abilities/item_abilities.gon",
				"./mewgenics-data/data/abilities/jester_abilities.gon",
				"./mewgenics-data/data/abilities/kaiju_abilities.gon",
				"./mewgenics-data/data/abilities/mage_abilities.gon",
				"./mewgenics-data/data/abilities/medic_abilities.gon",
				"./mewgenics-data/data/abilities/misc_abilities.gon",
				"./mewgenics-data/data/abilities/monk_abilities.gon",
				"./mewgenics-data/data/abilities/necromancer_abilities.gon",
				"./mewgenics-data/data/abilities/psychic_abilities.gon",
				"./mewgenics-data/data/abilities/rifthead_abilities.gon",
				"./mewgenics-data/data/abilities/special_enemy_abilities.gon",
				"./mewgenics-data/data/abilities/tank_abilities.gon",
				"./mewgenics-data/data/abilities/terminator_abilities.gon",
				"./mewgenics-data/data/abilities/test_abilities.gon",
				"./mewgenics-data/data/abilities/thief_abilities.gon",
				"./mewgenics-data/data/abilities/throbbing_king_abilities.gon",
				"./mewgenics-data/data/abilities/tinkerer_abilities.gon",
				"./mewgenics-data/data/abilities/util_abilities.gon",
			}
		}
	}
}
