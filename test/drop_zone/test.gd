extends Node2D

func _ready() -> void:
	pass

func _on_draggable_card_dropped() -> void:
	if ($DropZone.get_overlapping_areas().has($DraggableCard)):
		print("dropped inside")
		$DraggableCard.snap_to($DropZone.position)
