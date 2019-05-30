extends CanvasLayer

var index:int = 0
onready var buttons:Array = [$btn_cancel, $btn_title, $btn_desktop]
func _ready():
	for btn in buttons:
		btn.modulate = Color(1,1,1,.2)
	buttons[0].modulate = Color(1,1,1,1)

func _process(delta:float) -> void:
	var up:bool = Input.is_action_just_pressed("ui_up")
	var down:bool = Input.is_action_just_pressed("ui_down")
	var enter:bool = Input.is_action_just_pressed("ui_accept")

	if up || down:
		#GLOBAL.get_node("sfx/sfx_esc_select").play()

		for btn in buttons:
			btn.modulate = Color(1,1,1,.2)

		if up:
			index -= 1
			if index < 0:
					index = buttons.size()-1

		if down:
			index += 1
			if index > buttons.size()-1:
					index = 0

		buttons[index].modulate = Color(1,1,1,1)

	if enter:
		get_tree().paused = false
		get_node("/root/esc_scene").queue_free()
		match index:
			0:
				pass
			1:
				#GLOBAL.save_game()
				GLOBAL.next_scene("main_menu")
			2:
				get_tree().quit()