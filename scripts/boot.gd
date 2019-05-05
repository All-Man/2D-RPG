extends Node2D
func _ready() -> void:
	var fabenial_x:Vector2 = $fabenial.position

	$logo.modulate = Color(1,1,1,0)
	$fabenial.modulate = Color(1,1,1,0)
	$fabenial.position.x = $fabenial.position.x + 50

	$tween.interpolate_property($logo, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1, Tween.TRANS_LINEAR, 0)
	$tween.start()
	yield($tween, "tween_completed")

	$tween.interpolate_property($mask, "position", $mask.position, Vector2(-1, 0), 1.5, Tween.TRANS_SINE, Tween.EASE_OUT)
	$tween.start()
	yield(get_tree().create_timer(1.3), "timeout")

	$tween.interpolate_property($fabenial, "modulate", $fabenial.modulate, Color(1,1,1,1), 1, Tween.TRANS_LINEAR, 0)
	$tween.interpolate_property($fabenial, "position", $fabenial.position, fabenial_x, 1.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$tween.start()
	yield(get_tree().create_timer(1.6), "timeout")
	
	yield(get_tree().create_timer(1.2), "timeout")
	get_tree().change_scene("res://Level1.tscn")