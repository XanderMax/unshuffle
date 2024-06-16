@tool
class_name NumberCard extends Control


signal clicked()
signal double_clicked()


const _circle_unlocked_texture: Resource = preload("res://imgs/03_circle_white.png")
const _circle_locked_texture: Resource = preload("res://imgs/04_circle_white_gray_bg.png")


var _selected: bool = false


func _gui_input(event):
	if not (event is InputEventMouseButton):
		return
	var mouse_event:InputEventMouseButton = event as InputEventMouseButton
	if mouse_event.is_pressed() and mouse_event.button_index == MOUSE_BUTTON_LEFT:
		self.play_beat()
		self.clicked.emit()


func set_selected(selected: bool):
	print("card2::set_selected ", selected)
	if self._selected == selected:
		return
	self._selected = selected
	if self._selected:
		$Circle.modulate = Color.YELLOW
	else:
		$Circle.modulate = Color.WHITE


func is_selected() -> bool:
	return self._selected


func set_text(text: String):
	$NumberLabel.text = text


func get_text() -> String:
	return $NumberLabel.text


func play_beat():
	$AnimationPlayer.play("beat")
