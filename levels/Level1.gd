extends Node2D

func _ready():
	load_home()

func change_map(location):
	for i in $MAP.get_children():
		i.queue_free()
	match location:
		"Dung":
			load_dung()
		"Home":
			load_home()
		"FreeWorld":
			load_freeworld()

func load_dung():
	var map = preload("res://levels/Dange.tscn")
	var m = map.instance()
	$MAP.add_child(m)
	
func load_home():
	var map = preload("res://levels/HOME.tscn")
	var m = map.instance()
	$MAP.add_child(m)
func load_freeworld():
	var map = preload("res://levels/FreeWorld.tscn")
	var m = map.instance()
	$MAP.add_child(m)