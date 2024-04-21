extends Node

static var subscribers : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

static func add_listener(listener: Node, event: BasicEvent) -> void:
	#var event_class := ()
	print()
	if not subscribers.has(listener):
		pass
	pass
