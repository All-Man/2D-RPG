extends Node2D

var ExitPointsDict = {"homeexit":"MAP/home/HomeExit", "homeenter":"MAP/freeworld/HomeEnter"} # Этот тип данных назывется словарь, например значение 'MAP/Home/HomeExit' можно получит через ExitPointsDict["HomeExit"]
func _ready():
	load_home()

# Функция выбора карты для смены
func change_map(ToMap):
	for i in $MAP.get_children(): # Удаление всех дочерних объектов
		i.queue_free()
	match ToMap:
		"dung": # Условие
			load_dung() # Вызов функции
		"home":
			load_home()
		"freeworld":
			load_freeworld()
	change_pos(ToMap)

func change_pos(ToMap):
	print("Отладка: Переход из ", GLOBAL.map_name, " в ", ToMap)
	if(GLOBAL.map_name == "freeworld"):
		$KinematicPlayer.position = get_node(ExitPointsDict[ToMap + "exit"]).position # get_node - аналогично знаку $
	elif(GLOBAL.map_name == "home" || GLOBAL.map_name == "dung"):
		$KinematicPlayer.position = get_node(ExitPointsDict[GLOBAL.map_name + "enter"]).position
	GLOBAL.map_name = ToMap

func load_dung(): # Функция смены карты на Dange
	var map = preload("res://levels/dange.tscn")
	var m = map.instance()
	$MAP.add_child(m)
func load_home():
	var map = preload("res://levels/home.tscn")
	var m = map.instance()
	$MAP.add_child(m)
func load_freeworld():
	var map = preload("res://levels/freeworld.tscn")
	var m = map.instance()
	$MAP.add_child(m)