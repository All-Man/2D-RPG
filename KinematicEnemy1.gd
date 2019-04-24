extends KinematicBody2D

var IsPlayerNear = false
var SPEED = 120
var health = 100
var PlayerPos = Vector2(0,0)

func _physics_process(delta):
	$HealthBar.set_value(health)
	if(health <= 0):
		queue_free()
	if(IsPlayerNear == true):
		PlayerPos.x = $"../../../../KinematicPlayer".global_position.x - self.global_position.x
		PlayerPos.y = $"../../../../KinematicPlayer".global_position.y - self.global_position.y
		var motion = PlayerPos.normalized() * SPEED
		move_and_slide(motion, Vector2(0,0))
		
		rotation_loop()





func rotation_loop():
	if(PlayerPos.x < 0 && PlayerPos.y < 0): # 1 ая четверть окружности
		if(abs(PlayerPos.y) < abs(PlayerPos.x)):
			$AnimatedSprite.play("LEFT")
		elif(abs(PlayerPos.y) > abs(PlayerPos.x)):
			$AnimatedSprite.play("UP")
		else:
			$AnimatedSprite.stop()
	elif(PlayerPos.x > 0 && PlayerPos.y < 0): # 2 ая четверть окружности
		if(abs(PlayerPos.y) < abs(PlayerPos.x)):
			$AnimatedSprite.play("RIGHT")
		elif(abs(PlayerPos.y) > abs(PlayerPos.x)):
			$AnimatedSprite.play("UP")
		else:
			$AnimatedSprite.stop()
	elif(PlayerPos.x > 0 && PlayerPos.y > 0): # 3 ая четверть окружности
		if(abs(PlayerPos.y) < abs(PlayerPos.x)):
			$AnimatedSprite.play("RIGHT")
		elif(abs(PlayerPos.y) > abs(PlayerPos.x)):
			$AnimatedSprite.play("DOWN")
		else:
			$AnimatedSprite.stop()
	elif(PlayerPos.x < 0 && PlayerPos.y > 0): # 4 ая четверть окружности
		if(abs(PlayerPos.y) > abs(PlayerPos.x)):
			$AnimatedSprite.play("DOWN")
		elif(abs(PlayerPos.y) < abs(PlayerPos.x)):
			$AnimatedSprite.play("LEFT")
		else:
			$AnimatedSprite.stop()
	else:
		$AnimatedSprite.stop()


func attack():
	IsPlayerNear = true
func stop_attack():
	print("-----------------------")
	$AnimatedSprite.stop()
	IsPlayerNear = false

func _on_HitZone_area_entered(area):
	var groups = area.get_groups()
	if (groups.has("player")):
		print("EEEEBOYYY")
	if (groups.has("bullet")):
		health -= 10