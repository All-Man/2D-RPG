extends Area2D


func _on_player1_area_area_entered(area):
	var groups = area.get_groups()
	#print (groups)
	if(groups.has("bullet")):
		$"../".health -= 5
	