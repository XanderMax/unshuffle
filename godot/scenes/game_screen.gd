class_name GameScreen extends Control

const default_display_array: Array = [0, 1, 2, 3, 4, 5, 6, 7]
var _display_array: Array = default_display_array.duplicate(true)
var _hidden_array: Array
var _selected_card_index: int = -1

signal card_selected(index: int)
signal card_locked(index: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 8):
		var cardNode:Card = _get_card(i)
		if cardNode:
			cardNode.clicked.connect(func(): _on_card_clicked(i))
			cardNode.doubleClicked.connect(func(): _on_card_double_clicked(i))

func _get_card(index:int) -> Card:
	var node_name: String = "Card%d" % index
	var card_node: Card = get_node(node_name) as Card
	return card_node

func _on_card_clicked(index: int) -> void:
	assert(index >= 0 && index < self._display_array.size())
	self.card_selected.emit(index)
	if self._selected_card_index < 0 || self._selected_card_index >= self._display_array.size():
		self._selected_card_index = index
	else:
		var card1 = _get_card(index)
		var card2 = _get_card(self._selected_card_index)
		if card1 and card2:
			var tmp = self._display_array[index]
			self._display_array[index] = self._display_array[self._selected_card_index]
			self._display_array[self._selected_card_index] = tmp
			card1.setLabel(self._display_array[index])
			card2.setLabel(self._display_array[self._selected_card_index])
			self._selected_card_index = -1

func _on_card_double_clicked(index: int) -> void:
	var card_node: Card = _get_card(index) as Card
	if !card_node:
		return
	self.card_locked.emit(index)
	card_node.toggleLock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func reset(hidden_array: Array):
	if hidden_array.size() != default_display_array.size():
		return
	self._display_array = self.default_display_array.duplicate(true)
	self._hidden_array = hidden_array
	self._selected_card_index = -1
	for index in range(0, 8):
		var card: Card = _get_card(index)
		card.setLabel(self._display_array[index])
