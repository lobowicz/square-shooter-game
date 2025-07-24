extends Node2D

@onready var player = $Player
@onready var main_camera = $MainCamera


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.died.connect(_on_player_died)
	player.camera_remote_transform.remote_path = main_camera.get_path()


func _on_player_died():
	print("Game Over!")
	# reload the game not immediately, but after 2 seconds
	get_tree().create_timer(2).timeout.connect(get_tree().reload_current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
