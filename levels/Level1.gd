extends Node2D

var ExitPointsDict = {"HomeExit":"MAP/Home/HomeExit", "HomeEnter":"MAP/FreeWorld/HomeEnter"}
#	$KinematicPlayer.position = get_node(ExitPointsDict['Home']).position
func _ready():
	load_home()

# Функция выбора карты для смены
func change_map(location, FromMap, ToMap):
	for i in $MAP.get_children(): # Удаление всех дочерних объектов
		i.queue_free()
	match location:
		"Dung": # Условие
			load_dung() # Вызов функции
		"Home":
			load_home()
		"FreeWorld":
			load_freeworld()
	change_pos(FromMap, ToMap)

func change_pos(FromMap, ToMap):
	print("Отладка: Переход из ", FromMap, " в ", ToMap)
	if(FromMap == "FreeWorld"):
		$KinematicPlayer.position = get_node(ExitPointsDict[ToMap + "Exit"]).position
	elif(FromMap == "Home" || FromMap == "Dung"):
		$KinematicPlayer.position = get_node(ExitPointsDict[FromMap + "Enter"]).position

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