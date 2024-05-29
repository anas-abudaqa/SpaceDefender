extends Node2D

class_name ObstacleSpawner

signal WaveStarted
signal WaveEnded

var obstacles_in_wave: int = 0
var obstacles_in_wave_left: int = 0
#Player
@export var camera: Camera2D
#Enemy type to spawn:
var spikyrock_scene = preload("res://Levels/Level1/SpikyRock.tscn")

#func load_scene(enemy: CharacterBody2D ,path: String):
	#enemy = load(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func wave_start():
	WaveStarted.emit()
	print("Obstacle Spawner: Let's start")
	spawn_line()

func get_starting_point() -> Vector2:
	#returns all the way to the right, middle of the screen
	return camera.global_position + Vector2(640, 0)

func spawn_line():
	obstacles_in_wave = 3
	obstacles_in_wave_left = obstacles_in_wave
	var starting_position = get_starting_point()
	#800/2, or take 700 to give some bot and top margins
	var y_offset = -350
	for instance in obstacles_in_wave:
		var obstacle = spikyrock_scene.instantiate()
		get_tree().root.add_child(obstacle)
		obstacle.spawn(starting_position + Vector2(0, y_offset))
		obstacle.connect("RockGone", on_rock_gone)
		print("Obstacle Spawner: I have spawned an obstacle: ", obstacle)
		y_offset += 350



func on_rock_gone():
	obstacles_in_wave_left -= 1
	if obstacles_in_wave_left == 0:
		WaveEnded.emit()
		print("Obstacle Spawner: We ending the wave now")



func _on_level_1_start_spiky_rock_wave():
	wave_start()
