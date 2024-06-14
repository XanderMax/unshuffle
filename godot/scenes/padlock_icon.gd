class_name PadlockIcon extends TextureRect

signal clicked()


const _closed_padlock_texture: Resource = preload("res://imgs/01_padlock_icon_white_closed.svg")
const _opened_padlock_texture: Resource = preload("res://imgs/02_padlock_icon_white_open.svg")

var locked: bool = false:
	set(val):
		if val != locked:
			locked = val
			_update_icon()
			self.clicked.emit()


func _ready():
	_update_icon()


func _update_icon():
	if self.locked:
		self.texture = self._closed_padlock_texture
	else:
		self.texture = self._opened_padlock_texture


func _gui_input(event):
	if not (event is InputEventMouseButton):
		return
	var mouseEvent:InputEventMouseButton = event as InputEventMouseButton
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if not mouseEvent.double_click:
			self.locked = not self.locked
