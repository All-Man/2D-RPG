extends KinematicBody2D

const SPEED = 200

var movedir = Vector2(0,0)
var spritedir = "down"
var can_go = true
var can_fire = false
var how_fire = Vector2()
var fire_rotate = 0
var time = 5
var shoot_time = 1
var is_live = true

var health = 100

var Bullet = preload('res://player/Bullet.tscn')

func fire():
	var bul = Bullet.instance()
	bul.position = position + how_fire
	bul.rotation_degrees = fire_rotate
	get_node('../').add_child(bul)
	time = 0

func _physics_process(delta):
	controls_loop()
	movement_loop()
	spritedir_loop()
	
	time += delta
	if (time > shoot_time):
		time = 5
	
	$"../"/Bars/Player_bars/player2_mana_bar.set_value(time)
	$"../"/Bars/Player_bars/player2_health_bar.set_value(health)
	
	
	if (health == 0):
		health = -1
		time = 0
		is_live = false
		$"../"/EndGameScreen/CanvasLayer/Label.show()
	
	if (time > 1.4 and is_live == false):
		get_tree().paused = true
	
	#if is_on_wall():
	if (Input.is_action_pressed("ui_fire2")):
		
		if spritedir == "left":# and test_move(transform, Vector2(-1,0)):
			$anim.play("pushleft")
			can_go = false
			can_fire = false
			fire_rotate = -180
			how_fire = Vector2(-10, 2)
			if (time > shoot_time):
				fire()
			#anim_switch("push")
		if spritedir == "right":# and test_move(transform, Vector2(1,0)):
			$anim.play("pushright")
			can_go = false
			can_fire = false
			fire_rotate = 0
			how_fire = Vector2(10, 2)
			if (time > shoot_time):
				fire()
			#anim_switch("push")
		if spritedir == "up":# and test_move(transform, Vector2(0,-1)):
			$anim.play("pushup")
			can_go = false
			can_fire = false
			fire_rotate = -90
			how_fire = Vector2(0, -10)
			if (time > shoot_time):
				fire()
			#anim_switch("push")
		if spritedir == "down":# and test_move(transform, Vector2(0,1)):
			$anim.play("pushdown")
			can_go = false
			can_fire = false
			fire_rotate = 90
			how_fire = Vector2(0, 10)
			if (time > shoot_time):
				fire()
			#anim_switch("push")
	elif movedir != Vector2(0,0):
		anim_switch("walk")
		can_go = true
		can_fire = true
	else:
		anim_switch("idle")
		can_go = true
		can_fire = true
	

func controls_loop():
	var LEFT	= Input.is_action_pressed("ui_left2")
	var RIGHT	= Input.is_action_pressed("ui_right2")
	var UP		= Input.is_action_pressed("ui_up2")
	var DOWN	= Input.is_action_pressed("ui_down2")
	
	if (can_fire == false):
		movedir.x = 0
		movedir.y = 0
	if (can_go == true):
		movedir.x = -int(LEFT) + int(RIGHT)
		movedir.y = -int(UP) + int(DOWN)

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))

func spritedir_loop():
	
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"

func anim_switch(animation):
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)