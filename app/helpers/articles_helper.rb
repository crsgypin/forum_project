module ArticlesHelper

	def status_published?
		:status == "published"
	end

	def display_category(categoies)
		arr = categoies.map { |c|
			content_tag(:span, c.name, :class => "label label-primary" )
		}

		safe_join(arr, " ")
	end

end
