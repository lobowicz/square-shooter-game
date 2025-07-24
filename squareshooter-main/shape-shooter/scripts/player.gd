extends CharacterBody2D
class_name Player 
signal died 
@onready var camera_remote_transform = $CameraRemoteTransform

const SPEED = 400.0
var bullet_speed = 1500.0
var bullet = preload("res://scenes/bullet.tscn")



func _process(delta: float) -> void:
	look_at(get_global_mouse_position())


func _physics_process(delta: float) -> void:
	# get the horizontal and vertical coordinates 
	var move_dir = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	# check if the movement is not zero
	if move_dir != Vector2.ZERO:
		velocity = SPEED * move_dir.normalized()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	
	# check if LMB is being pressed, then shoot 
	if Input.is_action_just_pressed("shoot"):
		fire()


func _on_hitbox_body_entered(body: Node2D) -> void:
	# check if object colliding with player is the Enemy
	if (body is Enemy) or (body is EnemyBullet):
		died.emit()
		queue_free()


func fire():
	var bullet_instance = bullet.instantiate()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	
	if $PlayerShootSFX:
		$PlayerShootSFX.play()
	
	get_tree().get_root().call_deferred("add_child", bullet_instance)
