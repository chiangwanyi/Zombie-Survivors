@icon("res://Components/StateMachine/State.svg")
class_name State extends Node
# 所有state的基类: it doesn't do anything by itself,
# but forces us to pass the right arguments to the methods below
# and makes sure every State object had all of these methods.

var exit_flag : bool
var ready_flag : bool

# warning-ignore:unused_signal
signal finished(next_state_name)

# 用于进入当前 state 后的初始化操作. E.g. 切换 animation.
func enter() -> void:
	exit_flag = false
	ready_flag = true


# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	exit_flag = true
	ready_flag = false


func handle_input(_event: InputEvent) -> void:
	pass

# 由当前 state 的 state_machine 在 _physics_process 中调用
func update(_delta: float) -> void:
	pass
	
func integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	pass

func _on_animation_finished(_anim_name: StringName) -> void:
	pass
