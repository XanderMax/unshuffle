class_name GameScreen extends Control

const default_display_array: Array = [0, 1, 2, 3, 4, 5, 6, 7]
var _display_array: Array = default_display_array.duplicate(true)
var _hidden_array: Array
var _selected_card_index: int = -1
var _swaps_count: int = 0

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
			self._swap_cards(index, self._selected_card_index)
			self._update_match_count()
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

func _swap_cards(index0: int, index1: int):
	assert(index0 >= 0 and index0 < self._display_array.size())
	assert(index1 >= 0 and index1 < self._display_array.size())
	if index0 == index1:
		return
	var val0 = self._display_array[index0]
	var val1 = self._display_array[index1]
	var card0 = _get_card(index0)
	var card1 = _get_card(index1)
	assert(card0 and card1)
	self._display_array[index0] = val1
	self._display_array[index1] = val0
	card0.setLabel(val1 + 1)
	card1.setLabel(val0 + 1)
	self._set_swaps_count(self._swaps_count + 1)

func _count_matches() -> int:
	assert(self._hidden_array.size() == self._display_array.size())
	var matches_count = 0
	for i in range(self._hidden_array.size()):
		if self._hidden_array[i] == self._display_array[i]:
			matches_count = matches_count + 1
	return matches_count
	
func _set_swaps_count(swaps_count: int):
	self._swaps_count = swaps_count
	$SwapsCountLabel.text = "Swaps: %d" % self._swaps_count
	
func _update_match_count():
	$CenterContainer/MatchCountLabel.text = str(_count_matches())

func get_swaps_count() -> int:
	return self._swaps_count

func reset(hidden_array: Array):
	if hidden_array.size() != default_display_array.size():
		return
	self._display_array = self.default_display_array.duplicate(true)
	self._hidden_array = hidden_array
	self._selected_card_index = -1
	self._set_swaps_count(0)
	self._update_match_count()
	for index in range(0, 8):
		var card: Card = _get_card(index)
		card.setLabel(self._display_array[index] + 1)
