extends Node

var agents = []
var paths_calc_per_turn = 10
var i = 0

func _ready() -> void:
  self.set_physics_process(false)
  get_tree().create_timer(1).timeout.connect(func(): self.set_physics_process(true)) # wait NavigationServer synchronization

func _physics_process(delta: float) -> void:
  var update_targets = agents.slice(i, i + paths_calc_per_turn)
  for a in update_targets:
    var agent = a as MoveAgent
    var new_path = (agent.nav_agent as NavigationAgent3D).get_next_path_position()
    agent.next_path = new_path
  if (i + paths_calc_per_turn) >= agents.size():
    i = 0
  else:
    i += paths_calc_per_turn
  
