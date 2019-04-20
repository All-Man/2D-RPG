extends KinematicBody2D



func _on_AreaTop_area_entered(area):
	global_position.y += 1


func _on_AreaRight_area_entered(area):
	global_position.x += 1


func _on_AreaBottom_area_entered(area):
	global_position.y -= 1


func _on_AreaLeft_area_entered(area):
	global_position.x -= 1
