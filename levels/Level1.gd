extends Node2D

func _ready(): # Функция которая исполняется только один раз при запуске
	load_home()

# Функция выбора карты для смены
func change_map(location):
	for i in $MAP.get_children(): # Удаление всех дочерних объектов
		i.queue_free()
	match location:
		"Dung": # Условие
			load_dung() # Вызов функции
		"Home":
			load_home()
		"FreeWorld":
			load_freeworld()

func load_dung(): # Функция смены карты на Dange
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