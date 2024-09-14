extends Node2D

func check_puzzle_complete():
	var all_pieces_correct = true
	
	for piece in get_children():
		if piece is TextureRect and piece.correct_target:
			if piece.position != piece.correct_target.position:
				all_pieces_correct = false
				break

	if all_pieces_correct:
		print("Puzzle Complete!")
		# Trigger any additional logic (e.g., next level, victory message)
