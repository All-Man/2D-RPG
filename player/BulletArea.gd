extends Area2D


var SPEED = 250
var time = 0 # Объявление переменных

func boom():
		# "$" - обращение к ноде
		$bullet.stop() # Остановить анимацию полёта огня
		$bullet.hide() # Скрыть файрболл
		$explode.show() # Показать ноду взрыва
		$explode.play() # Воспроизвести взрыв


func _process(delta): # Функция котороая работает в течении всей игры
	
	time += delta # Время овеличивается постепенно
	if (time > 2): # Примерно через две секунды полёта взрыв огня
		boom() # Функция взрыва
		if (time > 2.3): 
			queue_free() # Примерно через 2.3 секунды нода файрболла полностью исчезает
	else:
		position.x += delta * SPEED # Изменение позиции по оси x
		
	

func _on_BulletArea_area_entered(area): # Если в зону файрболла попадает другая зона то
	var groups = area.get_groups() # Смотрим какие группы зоны попали в патрону
	if(groups.has("bullet_bullet")): # Если есть группа bullet_bullet
		remove_from_group("bullet") # Удаляем у себя группу bullet
	if(groups.has("Exit") || groups.has("noheavy")): # Если в зоне есть группы Exit или noheavy, то взрыв не происходит
		pass
	else: # Если их нет то взрыв происходит
		boom() # Происходит взрыв


func _on_BulletArea_body_entered(body):
	var groups = body.get_groups()
	#if(groups.has("noheavy")):
	#	pass
	#else:
	remove_from_group("bullet")
	boom()

