extends KinematicBody2D

const SPEED = 200 # Скорость передвижения игрока

var movedir = Vector2(0,0) # Текущее направляение движения
var spritedir = "down" # Направление персонажа
var can_go = true 
var can_fire = false
var how_fire = Vector2()
var fire_rotate = 0
var time = 5
var shoot_time = 1
var is_live = true
var is_moving = false


var health = 40 # ХП
var mana = 100 # Мана

var HealthRegenSpeed = 1 # Скорость регенерации маны
var ManaRegenSpeed = 2 # Скорость регенерации маны
var FireBallCost = 30 # Цена файрболла в мане
var FireBallDamage = 5

var Bullet = preload('res://player/Bullet.tscn') # В переменную Bullet пдгружаем сцену Bullet.tscn

func fire(): # Функция выстрела файрболлом
	if (mana > 30): # Тут и так всё ясно
		mana -= FireBallCost # Тут тоже, просто убираем цену выстрела
		var bul = Bullet.instance() # Хз что это, но оно работает
		bul.position = position + how_fire # Задаём начальное местоположение огня у рук перса
		bul.rotation_degrees = fire_rotate # Направляем патрону в ту сторону куда смотрит перс
		get_node('../').add_child(bul) # В ноде на уровень выше создаем файрболл
		time = 0

func _physics_process(delta): # Функция выполняется всегда
	controls_loop() # Функция управлением перса, можно было просто вставить весь код из функции сюда, но так читабельнее
	movement_loop() # То же
	spritedir_loop() # То же
	fire_loop() # То же
	
	time += delta # Счётчик временеи
	if (mana != 100): # Если кол-во маны не 100, то
		mana += delta * ManaRegenSpeed #Регенерация маны
	if (health != 100 && is_moving == false):  # Если кол-во маны не 100 и перс не движется, то
		health += delta * HealthRegenSpeed #Регенерация жизней
	if (time > shoot_time): # Не помню зачем делал, пока работает не надо трогать. Это связано с выстрелом файрболла
		time = 5
	
	$"../"/Bars/Player_bars/player1_mana_bar.set_value(mana) # Установка значения mana на полосу маны (синяя на экране)
	$"../"/Bars/Player_bars/player1_health_bar.set_value(health) # Установка значения health на полосу жизней (красная на экране)
	
	if (health == 0): # Если жизни по нулям
		health = -1 # Минусуем их
		time = 0 # Обнуляем таймер
		is_live = false # Значение что перс жив стало false
		$"../"/EndGameScreen/CanvasLayer/Label.show() # Показываем лейбл о том, что игра окончена
	
	if (time > 1.4 and is_live == false): # Если лейбл провисел на экране больше 1.4 секунды
		get_tree().paused = true # Останвливаем всю игру
	
func fire_loop():
	if (Input.is_action_pressed("ui_fire")): # Если нажата клавиша ui_fire сейчас это шифт
		
		# Если перс смортит влево
		if spritedir == "left":# and test_move(transform, Vector2(-1,0)): 
			$anim.play("pushleft") # Начинаем проигрывать анимацию наклона
			can_go = false # Не может двигаться
			can_fire = false # Не может стрелять
			fire_rotate = -180 # Изменаем поворот файрболла
			how_fire = Vector2(-10, 2) # Указываем куда файрболлу лететь
			if (time > shoot_time): # Если по времени можно выстреливать, то
				fire() # ОГОНЬ!
			#anim_switch("push")
			
			# Дальше то же самое
			
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
	elif movedir != Vector2(0,0): # Если вектор движения перса не нулевой, те. перс движется
		anim_switch("walk") # Меняем его анимацию на анимацию хождения
		can_go = true # Он может идти
		can_fire = true # Может стрелять
		is_moving = true # Запоминаем что перс движетя
	else: # В противном случае
		anim_switch("idle") # Меняем анимацию на анимацию ничего не делания
		can_go = true # Он может идти
		can_fire = true # Может стрелять
		is_moving = false # Запоминаем что перс стоит
	

func controls_loop():
	# Переменные ранящие в себе значения клавиш, true - нажата, false - не нажата
	var LEFT	= Input.is_action_pressed("ui_left") 
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	if (can_fire == false): # Если перс стреляет
		movedir.x = 0 # Перемещения по x нет
		movedir.y = 0 # Перемещения по y нет
	if (can_go == true): # Если перс может идти
		movedir.x = -int(LEFT) + int(RIGHT) # Устанавливаем куда идёт перс по x
		movedir.y = -int(UP) + int(DOWN) # Устанавливаем куда идёт перс по y

func movement_loop():
	var motion = movedir.normalized() * SPEED # normalized - усредняем движение перса, можно убрать, но ходить он будет не очень
	move_and_slide(motion, Vector2(0,0)) # Перемещаемся

func spritedir_loop(): # Функция устанавливает то куда смотрит перс
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"

func anim_switch(animation): # Функция смены анимации, что бы укоротить код
	var newanim = str(animation, spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)
		

func go_to_world(worldname): # Функция смены мира вызывается из ноды на уровень выше
	$"../".change_map(worldname)
	
func FireBallDamage():
	health -= FireBallDamage
