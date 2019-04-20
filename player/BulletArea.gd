extends Area2D

var time = 0

func boom():
		$bullet.stop()
		$bullet.hide()
		$explode.show()
		$explode.play()


func _process(delta):
	
	time += delta
	if (time > 2):
		boom()
		
		if (time > 2.3):
			queue_free()
	else:
		position.x += delta * 250
		
	

func _on_BulletArea_area_entered(area):
	var groups = area.get_groups()
	
 if(groups.has("bullet_bullet")):
		
		remove_from_group("bullet")
		
	boom()


func _on_BulletArea_body_entered(body):
	var groups = body.get_groups()
	if(groups.has("noheavy")):
		pass
	else:
		remove_from_group("bullet")
		boom()
		
	
