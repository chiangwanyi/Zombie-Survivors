# 游戏中所有事件的基类
class_name BasicEvent extends Object

# 事件通过 on_event 信号来通知事件订阅者
signal on_event(e: BasicEvent)

# FIXME: 目前没有找到更好的方式获取事件的名称，所有 BasicEvent 的子类必须设置 event_name
var event_name: StringName
