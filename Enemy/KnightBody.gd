extends Area2D



func _on_Body_area_entered(area):  # Если в зону проникли
	var groups = area.get_groups() 
	if (groups.has("player")):
		$"../".attack()


func _on_Body_area_exited(area):  # Если зону покинули
	var groups = area.get_groups()
	if (groups.has("player")):
		$"../".stop_attack()
