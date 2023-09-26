extends Node3D


@onready var nav_agent = $NavigationAgent3D as NavigationAgent3D
@export var debug := false
var target : Node3D

var speed = 3
var vec : Vector3
var loading = true

func _ready() -> void:
  target = get_tree().get_first_node_in_group("targets")
  nav_agent.target_position = target.global_position
  await get_tree().create_timer(1).timeout # wait NavigationServer synchronization
  loading = false
  


func _physics_process(delta: float) -> void:
  if loading: return
#  if nav_agent.is_navigation_finished():
#    return
  nav_agent.target_position = target.global_position
    
  var current_pos = global_position
  var next_path_pos = nav_agent.get_next_path_position()
  var dir = (next_path_pos - current_pos).normalized()
  global_translate(dir * speed * delta)
  
