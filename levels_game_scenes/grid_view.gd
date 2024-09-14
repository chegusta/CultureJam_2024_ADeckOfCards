extends TextureRect

var tweener: Tween

func move_grid_view(final_position):
	if tweener:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "position", final_position, 0.5).set_trans(Tween.TRANS_CUBIC) #return to center of viewport
