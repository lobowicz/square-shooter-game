extends CharacterBody2D
class_name Enemy

var player: Player = null

var speed: float = 200.0
var direction := Vector2.ZERO
var health: int = 3

var bullet_speed = 1000.0
var enemy_bullet = preload("res://scenes/enemy_bullet.tscn")
@onready var fire_timer = $Timer


func _process(delta: float) -> void:
	if player != null:
		look_at(player.global_position)


func _physics_process(delta: float) -> void:
	# get the direction and calc. position
	if player != null:
		var enemy_to_player = (player.global_position - global_position)
		if enemy_to_player.length() > 30.0:
			direction = enemy_to_player.normalized()	
		else:
			direction = Vector2.ZERO

		# if you put out of the if block above, enemy keeps chasing you when out of range
		if direction != Vector2.ZERO:
			velocity = speed * direction.normalized()
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
		
		move_and_slide()


func _on_player_detector_body_entered(body: Node2D) -> void:
	# check if it is the player that has entered body
	if body is Player:
		if player == null:
			player = body
			print(name + " found the player")
			fire_timer.start()


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body is Player:
		if player != null:
			player = null
			print(name + " lost the player")
			fire_timer.stop()


func _on_damage_detector_body_entered(body: Node2D) -> void:
	if body is Bullet:
		health -= 1
	if health <= 0:
		queue_free()





# functions to handle enemy firing 
func _on_timer_timeout() -> void:
	if player != null:
		fire()

#func fire():
	#var bullet_instance = bullet.instantiate()
	#bullet_instance.position = get_global_position()
	#bullet_instance.rotation_degrees = rotation_degrees
	#bullet_instance.linear_velocity = Vector2(bullet_speed, 0).rotated(rotation)
	#get_tree().get_root().call_deferred("add_child", bullet_instance)

func fire():
	var bullet_instance = enemy_bullet.instantiate()
	bullet_instance.position = global_position
	bullet_instance.rotation_degrees = rotation_degrees
	# Set bullet velocity towards the player
	var direction_to_player = (player.global_position - global_position).normalized()
	bullet_instance.linear_velocity = direction_to_player * bullet_speed
	
	if $EnemyShootSFX:
		$EnemyShootSFX.play()
	
	get_tree().get_root().call_deferred("add_child", bullet_instance)
