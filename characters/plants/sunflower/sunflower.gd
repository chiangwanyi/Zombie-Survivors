extends Plant

@onready var state_machine: StateMachine = $StateMachine
@onready var sfx_plant: AudioStreamPlayer = $SfxPlant
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
    animated_sprite_2d.play("idle")
    #sfx_plant.play()
    state_machine.start()
