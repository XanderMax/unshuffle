class_name Card extends TextureRect

var _locked:bool = false
var _clickTimer: Timer = Timer.new()

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
	_clickTimer.start(0.5)

func _on_click_timer_timeout() -> void:
	print("_on_click_timer_timeout")
	self.clicked.emit()
	
func _on_double_click() -> void:
	print("_on_double_click")
	self._clickTimer.stop()
	self.doubleClicked.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func toggleLock() -> bool:
	_locked = !_locked
	print("toggleLock ", _locked)
	return _locked
	
func setLabel(value:int) -> void:
	$CenterContainer/Label.text = str(value)
