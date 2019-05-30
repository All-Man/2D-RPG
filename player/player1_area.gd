extends Area2D

var NextWorld
var CanExit:bool = false

func _physics_process(delta):
	if (CanExit && Input.is_action_pressed("ui_use")): # Ели нажат ui_use т.е. кнопка Е
		$"../".go_to_world(NextWorld)

func _on_player1_area_area_entered(area): # Если в зоне игрока оказалась другая зона
	var groups = area.get_groups() # Получаем группы той зоны которая в нас попала
	if(groups.has("bullet")): # Если в том что в нас попало есть группа bullet
		$"../".FireBallDamage() # Вызываем функцию получения урона из ноды KinematicPlayer
	if(groups.has("exit")): # Если в группах еть группа Exit, те. через неё мы можем перейди в другую локацию
		CanExit = true
		$"../".use_hint("Show")
		# Так как местоположение групп всегда рандомное, и они записаны в массив проверяем и находим под какой цифрой Exit а под какой название мира куда надо перейти
		if(groups[0] == "exit"):
			NextWorld = groups[1] # Меняем мир на значение второго элемента массива т.к. в первом элементе лежит Exit
		elif(groups[1] == "exit"):
			NextWorld = groups[0] # То же только наоборот
	

func _on_player1_area_area_exited(area):
	var groups = area.get_groups()
	if(groups.has("exit")): # Если в группах еть группа Exit, те. через неё мы можем перейди в другую локацию
		CanExit = false
		$"../".use_hint("Hide") # Скрыть подсказку нажатия клавишы "E"