extends KinematicBody2D


var SPEED = 150



func _physics_process(delta):

	var MOVE = Vector2()
	var body = get_node("Body").get_overlapping_bodies()
	
	if(body.size() != 0):
		for tinge in body:
			if(tinge.is_in_group("player")):
				print('kek')
				#if(tinge.global_position().x < self.global_position().x):
				#	print('good')
