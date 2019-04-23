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




func attack():
	IsPlayerNear = true
func stop_attack():
	IsPlayerNear = false

func _on_HitZone_area_entered(area):
	var groups = area.get_groups()
	if (groups.has("player")):
		print("EEEEBOYYY")
	if (groups.has("bullet")):
		health -= 10