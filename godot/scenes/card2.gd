class_name Card2 extends Control


signal clicked()


const _circle_unlocked_texture: Resource = preload("res://imgs/03_circle_white.png")
const _circle_locked_texture: Resource = preload("res://imgs/04_circle_white_gray_bg.png")


var locked:bool = false:
	set(val):
		print("card2::locked::set(", val, ")")
		if val != locked:
			locked = val
			_update_locked()
		
var selected: bool = false:
	set(val):
		print("card2::selected:set(", val, ")")
		if val != selected:
			selected = val
			_update_selected()


func _gui_input(event):
	if not (event is InputEventMouseButton):
		return
	var mouseEvent:InputEventMouseButton = event as InputEventMouseButton
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if not mouseEvent.double_click:
			self.clicked.emit()


func _update_locked():
	if self.locked:
		$Circle.texture = self._circle_locked_texture
	else:
		$Circle.texture = self._circle_unlocked_texture


func _update_selected():
	if self.selected:
		$Circle.modulate = Color.YELLOW
	else:
		$Circle.modulate = Color.WHITE


func set_text(text: String):
	$NumberLabel.text = text


func get_text() -> String:
	return $NumberLabel.text
