extends Node3D

@export var fire_rate = 1.0
@export var missile_speed = 70
@export var missile_turn_speed = 150.0

var target : Node3D
var missile_obj = preload("res://scenes/HomingMissale/missile.tscn")

func _ready() -> void:
  var targets = get_tree().get_nodes_in_group("targets")
  if targets.size() == 0:
    return
  target = targets[0]
  $FireTimer.timeout.connect(fire)
  $FireTimer.wait_time = fire_rate
  $FireTimer.start()

func fire():
  var missile = missile_obj.instantiate() as Missile
  missile.setup(target, missile_speed, missile_turn_speed)
  missile.global_transform = $LauncherBase/FirePoint.global_transform
  get_tree().root.add_child(missile)
