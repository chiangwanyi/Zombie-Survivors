class_name GUIFollowMouseAbility extends GUIAbility

var control: Control

func _ready() -> void:
	if owner is Control:
		control = owner

func _input(event: InputEvent) -> void:
	if control and event is InputEventMouse:
		control.position = (event as InputEventMouse).position - control.size / 2

