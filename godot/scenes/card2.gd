class_name Card2 extends AspectRatioContainer

const _circle_unlocked_texture: Resource = preload("res://imgs/03_circle_white.png")
const _circle_locked_texture: Resource = preload("res://imgs/04_circle_white_gray_bg.png")

var _locked:bool = false
var _selected: bool = false
var _click_timer: Timer = Timer.new()

signal clicked()
signal double_clicked()

# Called when the node enters the scene tree for the first time.
func _ready():
	self._click_timer.one_shot = true
	self._click_timer.timeout.connect(_on_click_timer_timeout)
	self.add_child(_click_timer)

func _gui_input(event):
	if not (event is InputEventMouseButton):
		return
	var mouseEvent:InputEventMouseButton = event as InputEventMouseButton
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if mouseEvent.double_click:
			_on_double_click()
		else:
			_on_click()
			
	
func _on_click():
	print("card2::_on_click")
	_click_timer.start(0.25)


func _on_click_timer_timeout():
	print("card2::_on_click_timer_timeout")
	self.clicked.emit()


func _on_double_click():
	print("card2::_on_double_click")
	self._click_timer.stop()
	self._toggle_locked()
	self.double_clicked.emit()


func _toggle_locked():
	self._locked = not self._locked
	print("card2::_toggle_locked ", self._locked)
	if self._locked:
		$Circle.texture = self._circle_locked_texture
	else:
		$Circle.texture = self._circle_unlocked_texture


func is_locked() -> bool:
	return self._locked


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
