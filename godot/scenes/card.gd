class_name Card extends TextureRect

var _locked:bool = false
var _clickTimer: Timer = Timer.new()

const _closed_padlock_texture: Resource = preload("res://imgs/01_padlock_icon_white_closed.svg")
const _opened_padlock_texture: Resource = preload("res://imgs/02_padlock_icon_white_open.svg")

signal clicked()
signal doubleClicked()

# Called when the node enters the scene tree for the first time.
func _ready():
	self._clickTimer.one_shot = true
	self._clickTimer.timeout.connect(_on_click_timer_timeout)
	self.add_child(_clickTimer)

func _gui_input(event):
	if not (event is InputEventMouseButton):
		return
	var mouseEvent:InputEventMouseButton = event as InputEventMouseButton
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if mouseEvent.double_click:
			_on_double_click()
		else:
			_on_click()

func _on_click() -> void:
	print("_on_click")
	_clickTimer.start(0.25)

func _on_click_timer_timeout() -> void:
	print("_on_click_timer_timeout")
	if _locked:
		_flash_closed_padlock()
	else:
		self.clicked.emit()
	
func _on_double_click() -> void:
	print("_on_double_click")
	self._clickTimer.stop()
	self.doubleClicked.emit()
	
func _flash_closed_padlock():
	$AnimationPlayer.stop()
	if $CenterContainer/PadlockIcon.texture != _closed_padlock_texture:
		$CenterContainer/PadlockIcon.texture = _closed_padlock_texture
	$AnimationPlayer.play("padlock_fadeout")
	
func _flash_open_padlock():
	$AnimationPlayer.stop()
	if $CenterContainer/PadlockIcon.texture != _opened_padlock_texture:
		$CenterContainer/PadlockIcon.texture = _opened_padlock_texture
	$AnimationPlayer.play("padlock_fadeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func toggleLock() -> bool:
	_locked = !_locked
	print("toggleLock ", _locked)
	if _locked:
		_flash_closed_padlock()
		$CenterContainer/Label.modulate = Color(1., 1., 1., .3)
	else:
		_flash_open_padlock()
		$CenterContainer/Label.modulate = Color.WHITE
	return _locked
	
func setLabel(value:int) -> void:
	$CenterContainer/Label.text = str(value)
