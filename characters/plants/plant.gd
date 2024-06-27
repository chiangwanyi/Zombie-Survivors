class_name Plant extends Area2D

@onready var state_machine: StateMachine = $StateMachine
@onready var wand: Wand = $Wand

var plant_name: String

func _ready() -> void:
    state_machine.start()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
        get_tree().call_group("plant_info", "show_info", plant_name, wand)
