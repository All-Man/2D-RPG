extends KinematicBody2D

var IsPlayerNear = false
var SPEED = 120
var PlayerPos = Vector2(0,0)

func _physics_process(delta):
	if(IsPlayerNear == true):
		PlayerPos.x = $"../../../../KinematicPlayer".global_position.x - self.global_position.x
		PlayerPos.y = $"../../../../KinematicPlayer".global_position.y - self.global_position.y
		var motion = PlayerPos.normalized() * SPEED
		move_and_slide(motion, Vector2(0,0))




func attack():
	IsPlayerNear = true
	
func stop_attack():
	IsPlayerNear = false