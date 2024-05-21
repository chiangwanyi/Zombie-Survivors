@icon("res://components/state_machine/state.svg")
class_name State extends Node
# 所有state的基类: it doesn't do anything by itself,
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.

var is_exiting : bool
var is_ready : bool

# warning-ignore:unused_signal
signal finished(next_state_name)

# 用于进入当前 state 后的初始化操作. E.g. 切换 animation.
func enter() -> void:
	is_exiting = false
	is_ready = true


# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	is_exiting = true
	is_ready = false


func is_active() -> bool:
	return is_ready and not is_exiting


func handle_input(_event: InputEvent) -> void:
	pass


# 由当前 state 的 state_machine 在 _physics_process 中调用
func physics_update(_delta: float) -> void:
	pass


# 由当前 state 的 state_machine 在 _process 中调用
func update(_delta: float) -> void:
	pass

