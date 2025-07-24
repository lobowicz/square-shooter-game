extends RigidBody2D
class_name Bullet


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# after 3 secs clear the bullets 
	await get_tree().create_timer(3.0).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
