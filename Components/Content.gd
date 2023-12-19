extends MarginContainer


func _process(_delta):
	self.rect_min_size.y = $RichTextLabel.get_content_height()
