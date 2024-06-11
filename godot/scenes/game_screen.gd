class_name GameScreen extends Control

signal card_selected(index: int)
signal card_locked(index: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 8):
		var cardNode:Card = _get_card(i)
		if cardNode:
			cardNode.setLabel(i + 1)
			cardNode.clicked.connect(func(): _on_card_clicked(i))
			cardNode.doubleClicked.connect(func(): _on_card_double_clicked(i))
		

func _get_card(index:int) -> Card:
	var node_name: String = "Card%d" % index
	var card_node: Card = get_node(node_name) as Card
	return card_node
	
func _on_card_clicked(index: int) -> void:
	self.card_selected.emit(index)
	
func _on_card_double_clicked(index: int) -> void:
	var card_node: Card = _get_card(index) as Card
	if !card_node:
		return
	self.card_locked.emit(index)
	card_node.toggleLock()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
