extends Area2D



func _on_Body_area_entered(area):
	var groups = area.get_groups()
	if (groups.has("player")):
		$"../".attack()


func _on_Body_area_exited(area):
	var groups = area.get_groups()
	if (groups.has("player")):
		$"../".stop_attack()
