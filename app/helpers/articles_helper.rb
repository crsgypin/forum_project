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

	def display_tag(tags)
		arr = tags.map{|t| 
				content_tag(:span, t.name, :class=>"label label-primary")
		}
		safe_join(arr," ")
	end

end
