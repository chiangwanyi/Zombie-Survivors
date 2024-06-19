extends Plant

@onready var state_machine: StateMachine = $StateMachine
@onready var sfx_plant: AudioStreamPlayer = $SfxPlant
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var handle_weapon_ability: CharacterHandleWeaponAbility = $HandleWeaponAbility

func _ready() -> void:
    animated_sprite_2d.play("idle")
    #sfx_plant.play()
    state_machine.start()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
     if event is InputEventMouseButton:
         if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
             handle_weapon_ability.shoot_start()
