extends Node

signal WaveStarted
signal WaveEnded

@export var camera: Camera2D
@export var player: CharacterBody2D
var powerUp_scene = preload("res://PowerUps/power_up.tscn")

var powerUp_dictionary: Dictionary = {
	1: "res://PowerUps/rocket_shooter.tscn",
	2: "res://PowerUps/laser_cannon.tscn",
	3: "res://PowerUps/shielder_ship.tscn",
	4: "res://PowerUps/player_split_laser.tscn",
	5: "res://PowerUps/player_double_laser.tscn",
	6: "res://PowerUps/thruster.tscn"
}

func spawn_pickup():
	if not powerUp_dictionary.is_empty():
		WaveStarted.emit()
		var powerUp = powerUp_scene.instantiate()
		var starting_position = get_spawn_coordinates()
		get_tree().root.add_child(powerUp)
		powerUp.spawn(starting_position)
		powerUp.connect("PowerUpPickedUp", on_powerUp_pickedUp)
	else:
		print("PowerUp Spawner: No more abilities to unlock brother")
		WaveEnded.emit()
	
func get_spawn_coordinates() -> Vector2:
	return camera.global_position

func on_powerUp_pickedUp(powerUp_ID):
	print("PowerUp Spawner: Our current powerUp ID is ", powerUp_ID)
	#if this ID exists as a key in the dictionary
	if powerUp_dictionary.has(powerUp_ID):
		unlock_powerUp(powerUp_ID)	
	else: 
		while powerUp_dictionary.has(powerUp_ID) == false:
			print("PowerUp Spawner: Oh-oh, we need to reroll ", powerUp_ID)
			powerUp_ID = get_random_ID()
		print("PowerUp Spawner: Okay now we can use this one ", powerUp_ID)
		unlock_powerUp(powerUp_ID)

func get_random_ID() -> int:
	var keys_array = powerUp_dictionary.keys()
	var dictionary_size = powerUp_dictionary.size()
	var random_ID = randi_range(0, dictionary_size - 1)
	#if dictionary_size > 1:
	return keys_array[random_ID]
	#else: 
	#return keys_array[0]
	

func unlock_powerUp(powerUp_ID):
	#get the path from the powerUp dictionary using the ID as the key
	var powerUp_path_unlocked = powerUp_dictionary[powerUp_ID]
	#call the function from the AllKnowing script to notify the player of a new powwer up. Pass on the path of this power up
	AllKnowing.new_powerUp_available(powerUp_path_unlocked)
	#Delete the powerUp from the dictionary so it cannot be accessed again 
	powerUp_dictionary.erase(powerUp_ID)
	#Notify Level we are done with this
	WaveEnded.emit()

func _on_level_1_start_power_up_spawner():
	spawn_pickup()
