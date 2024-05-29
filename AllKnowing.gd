extends Node

signal PowerUpUnlocked(powerUp_path)

var player_health_modifier: int = 0
var player_shot_damage_modifier: int = 0
var player_lives_left: int
var player_level: int = 0
##total earned xp
var total_player_xp: int = 0
##xp earned during current level
var xp: int = 0
##xp needed to level up to next level
var xp_required_for_next_level: int = 0
##Skill points available for player to use
var available_skill_points: int = 12


var player_deaths: int = 0
var total_time_played: int = 0

var unlocked_powerups = []
var skill_tree_dictionary = {
	"HP+": 0,
	"Life+": 0,
	"AutoRepair": 0,
	"RegShield": 0,
	"DMG+": 0,
	"ChrgShot": 0,
	"Absorber": 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	xp_required_for_next_level = get_required_xp(player_level + 1)

func get_required_xp(level: int) -> int:
	return round(level * 4 + pow(level, 1.8) * 15)

func grant_XP(XP_gained: int):
	#Add to total xp
	total_player_xp += XP_gained
	#Add to current xp 
	xp += XP_gained
	#If we have more or equal xp to required xp, then subtract them. This is to allow multiple level ups when player gets a bunch of XP
	while xp >= xp_required_for_next_level:
		xp -= xp_required_for_next_level
		level_up()
	print("AllKnowing: We just got this much XP ", XP_gained)
	print("AllKnowing: We have this much XP ", total_player_xp)
	print("AllKnowing: We need this much XP to level up ", xp_required_for_next_level)
	get_tree().call_group("Shield", "decrease_cooldown_time")
	get_tree().call_group("LaserCannon", "decrease_cooldown_time")


func level_up():
	player_level += 1
	available_skill_points += 1
	xp_required_for_next_level = get_required_xp(player_level + 1)
	print("AllKnowing: We currently are level : ", player_level)

func add_to_death_counter():
	player_deaths += 1

##Add to our array, and call the function unlock_powerUp from nodes in group Player, with the path as an argument to the function
func new_powerUp_available(powerUp_path: String):
	unlocked_powerups.append(powerUp_path)
	get_tree().call_group("Player", "unlock_powerUp", powerUp_path)
	

func update_skill_tree(skill_name: String, skill_level: int):
	skill_tree_dictionary[skill_name] = skill_level

