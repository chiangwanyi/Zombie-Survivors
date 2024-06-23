extends Node2D

func _ready():
    GameManager.current_level = self

## 处理鼠标左键点击事件
func _input(event):
    if event is InputEventMouseButton and event.button_index ==  MOUSE_BUTTON_LEFT and event.pressed:
        # 遍历所有植物
        for plant in GameManager.plants:
            # 获取名为HandleWeaponAbility的子节点
            if plant.has_node("HandleWeaponAbility"):
                # 获取HandleWeaponAbility节点
                var handle_weapon_ability = plant.get_node("HandleWeaponAbility") as CharacterHandleWeaponAbility
                handle_weapon_ability.shoot_start()
                
            
