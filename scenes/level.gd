extends Node2D

var game_event := GameEvent.new()

func _ready() -> void:
	game_event.game_paused.connect(on_game_paused)
	
	EventManager.add_listener(self, game_event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_game_paused() -> void:
	print("game is pause")
