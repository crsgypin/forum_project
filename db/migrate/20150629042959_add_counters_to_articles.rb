class AddCountersToArticles < ActiveRecord::Migration

  def change
	add_column :articles, :views_count, :integer
	add_column :articles, :last_comment_at, :datetime
	add_column :articles, :comments_count, :integer

	Article.all.each do |a|
		a.views_count = a.article_views.count
		a.comments_count = a.comments.count
		a.last_comment_at = a.comments.order("id DESC").last.try(:created_at)
		a.save
	end

  end

end
