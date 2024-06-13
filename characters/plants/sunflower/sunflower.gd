extends Plant

@onready var state_machine: StateMachine = $StateMachine
@onready var sfx_plant: AudioStreamPlayer = $SfxPlant

func _ready() -> void:
    #sfx_plant.play()
    state_machine.start()
