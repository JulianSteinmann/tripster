class RemoveContentFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :content
  end
end
