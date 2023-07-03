class RemoveParentCommentIdFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :parent_comment_id, :integer
    remove_index :comments, :parent_comment_id if index_exists?(:comments, :parent_comment_id)
  end
end
