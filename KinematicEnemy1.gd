extends KinematicBody2D

var IsPlayerNear:bool = false
var SPEED:int = 140
var health:int = 150
var PlayerPos = Vector2(0,0)
var CanHitPlayer:bool = false
var BulletDamage:int = 10

func _physics_process(delta):
	$HealthBar.set_value(health)
	if(health <= 0):
		queue_free()
	if(IsPlayerNear == true):
		PlayerPos.x = $"../../../../KinematicPlayer".global_position.x - self.global_position.x
		PlayerPos.y = $"../../../../KinematicPlayer".global_position.y - self.global_position.y
		var motion = PlayerPos.normalized() * SPEED
		move_and_slide(motion, Vector2(0,0))
		if(!CanHitPlayer):
			rotation_loop()
		else:
			$AnimatedSprite.stop()





func rotation_loop(): # Супер сложная математическая функция
	if(PlayerPos.x < 0 && PlayerPos.y < 0): # 1 ая четверть окружности
		if(abs(PlayerPos.y) < abs(PlayerPos.x)):# нижняя половина четверти
			$AnimatedSprite.play("LEFT") # Начать проигрывать анимацию
		elif(abs(PlayerPos.y) > abs(PlayerPos.x)):# верхняя половина четверти
			$AnimatedSprite.play("UP")
		else:
			$AnimatedSprite.stop()
	elif(PlayerPos.x > 0 && PlayerPos.y < 0): # 2 ая четверть четверти
		if(abs(PlayerPos.y) < abs(PlayerPos.x)):# нижняя половина четверти
			$AnimatedSprite.play("RIGHT")
		elif(abs(PlayerPos.y) > abs(PlayerPos.x)):# верхняя половина четверти
			$AnimatedSprite.play("UP")
		else:
			$AnimatedSprite.stop()
	elif(PlayerPos.x > 0 && PlayerPos.y > 0): # 3 ая четверть четверти
		if(abs(PlayerPos.y) < abs(PlayerPos.x)):# верхняя половина четверти
			$AnimatedSprite.play("RIGHT")
		elif(abs(PlayerPos.y) > abs(PlayerPos.x)):# нижняя половина четверти
			$AnimatedSprite.play("DOWN")
		else:
			$AnimatedSprite.stop()
	elif(PlayerPos.x < 0 && PlayerPos.y > 0): # 4 ая четверть четверти
		if(abs(PlayerPos.y) > abs(PlayerPos.x)):# нижняя половина четверти
			$AnimatedSprite.play("DOWN")
		elif(abs(PlayerPos.y) < abs(PlayerPos.x)):# верхняя половина четверти
			$AnimatedSprite.play("LEFT")
		else:
			$AnimatedSprite.stop() # Перестать проигрывать анимацию
	else:
		$AnimatedSprite.stop()


func attack():
	IsPlayerNear = true
func stop_attack():
	$AnimatedSprite.stop()
	IsPlayerNear = false

func _on_HitZone_area_entered(area): # Функция будущей атаки, необходимо дописать
	var groups = area.get_groups()
	if (groups.has("player")):
		CanHitPlayer = true

func _on_Area2D_area_entered(area):
	var groups = area.get_groups()
	if (groups.has("bullet")):
		health -= BulletDamage


func _on_HitZone_area_exited(area):
	var groups = area.get_groups()
	if (groups.has("player")):
		CanHitPlayer = false
