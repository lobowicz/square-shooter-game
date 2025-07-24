extends StaticBody2D
class_name Box

var durability: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_detector_body_entered(body: Node2D) -> void:
	if body is Bullet:
		durability -= 1
		print("Box was hit. Remaining durability " + str(durability))
	
	if durability <= 0:
		queue_free()
