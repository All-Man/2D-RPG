extends Area2D


func _on_player1_area_area_entered(area):
	var groups = area.get_groups()
	print (groups[1])
	if(groups.has("bullet")):
		$"../".health -= 5
	if(groups.has("Exit")):
		if(groups[0] == "Exit"):
			$"../".go_to_world(groups[1])
		else:
			$"../".go_to_world(groups[0])
	