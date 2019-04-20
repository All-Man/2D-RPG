extends RigidBody2D

#Константы персонажа
const SPEED = 300

var vel = Vector2()
func _physics_process(delta):
	#Вверх
	if (Input.is_action_pressed("ui_up")):
		$Animated_player.play("UP")
		global_position.y += -SPEED * delta
	#Вниз
	elif (Input.is_action_pressed("ui_down")):
		$Animated_player.play("DOWN")
		global_position.y += SPEED * delta
	#Вправо
	elif (Input.is_action_pressed("ui_right")):
		$Animated_player.play("RIGHT")
		global_position.x += SPEED * delta
	#Влево
	elif (Input.is_action_pressed("ui_left")):
		$Animated_player.play("LEFT")
		global_position.x += -SPEED * delta
	else:
		$Animated_player.stop()
		$Animated_player.frame = 0