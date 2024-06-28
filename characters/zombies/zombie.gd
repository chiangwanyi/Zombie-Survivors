class_name Zombie extends Area2D

@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
    state_machine.start()
