class_name State extends Node
# 所有state的基类: it doesn't do anything by itself,
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.

# warning-ignore:unused_signal
signal finished(next_state_name)

# Initialize the state. E.g. change the animation.
func enter() -> void:
	pass


# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	pass


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta) -> void:
	pass


func _on_animation_finished(_anim_name: StringName) -> void:
	pass
