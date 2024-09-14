extends Button

var tweener : Tween

func button_appear():
	if tweener:
		tweener.kill()
	tweener = create_tween()
	tweener.tween_property(self, "position", Vector2(236, 1150), 0.5).set_trans(Tween.TRANS_CUBIC) #return to center of viewport
