class AddUserIdToRecipesAndCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :user_id, :int
    add_column :recipes, :user_id, :int
  end
end
