extends KinematicBody2D

var center_position:Vector2 = position
var sword_side
var radius 
var speed = 1
var last_rotation
var long = 2.5
var attack = false

func _ready():
	#set_sword_position(40, "left")
	hide()
	$Area2D/CollisionShape2D.disabled = true

func disable_sword():
	$Area2D/CollisionShape2D.disabled = true
	
func enable_sword():
	$Area2D/CollisionShape2D.disabled = true

func rotation_loop(mv): # x^2 + y^2 = r^2
	if(sword_side == "up"):

		if (position.x > radius/long):
			speed = -speed
		if (position.x < -radius/long):
			speed = -speed
		if (position.y > radius):
			speed = -speed
		if (position.y < -radius):
			speed = -speed
		position.x += speed
		if(speed > 0):
			position.y = -sqrt(radius*radius - position.x*position.x) * speed
		if(speed < 0):
			position.y = sqrt(radius*radius - position.x*position.x) * speed
		rotation_degrees += speed

	if(sword_side == "down"):

		if (position.x > radius/long):
			speed = -speed
		if (position.x < -radius/long):
			speed = -speed
		if (position.y > radius):
			speed = -speed
		if (position.y < -radius):
			speed = -speed
		position.x += speed
		if(speed > 0):
			position.y = sqrt(radius*radius - position.x*position.x) * speed
		if(speed < 0):
			position.y = -sqrt(radius*radius - position.x*position.x) * speed
		rotation_degrees -= speed

	if(sword_side == "right"):
		if (position.x > radius):
			speed = -speed
		if (position.x < -radius):
			speed = -speed
		if (position.y > radius/long):
			speed = -speed
		if (position.y < -radius/long):
			speed = -speed
		position.y += speed 
		if(speed > 0):
			position.x = sqrt(radius*radius - position.y*position.y) * speed
		if(speed < 0):
			position.x = -sqrt(radius*radius - position.y*position.y) * speed
		rotation_degrees += speed

	if(sword_side == "left"):
		if (position.x > radius):
			speed = -speed
		if (position.x < -radius):
			speed = -speed
		if (position.y > radius/long):
			speed = -speed
		if (position.y < -radius/long):
			speed = -speed
		position.y += speed 
		if(speed > 0):
			position.x = -sqrt(radius*radius - position.y*position.y) * speed
		if(speed < 0):
			position.x = sqrt(radius*radius - position.y*position.y) * speed
		rotation_degrees -= speed
		
		
#		if (position.x > radius):
#			speed = -speed
#		if (position.x < -radius):
#			speed = -speed
#		if (position.y > radius):
#			speed = -speed
#		if (position.y < -radius):
#			speed = -speed
#		position.x += speed * mv
#		if(speed > 0):
#			position.y = radius*radius - position.x*position.x
#		if(speed < 0):
#			position.y = -(radius*radius - position.x*position.x)
	#print(position.x, " | ", position.y, " | ", mv)

func stop_play():
	attack = false

func set_sword_position(move, side):
	attack = true
	sword_side = side
	radius = move
	position.x = 0
	position.y = 0
	if(side == "left"):
		position.x = -move
		rotation_degrees = -135
	elif(side == "right"):
		position.x = move
		rotation_degrees = 45
	elif(side == "up"):
		position.y = -move
		rotation_degrees = -45
	elif(side == "down"):
		position.y = move
		rotation_degrees = 135
	last_rotation = rotation_degrees
	print(position.x, " | ", position.y)
	
	

func _physics_process(delta):
	if(attack):
		rotation_loop(delta)
	pass