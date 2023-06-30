class Category < ApplicationRecord
    validates :name, presence: true, uniqueness: true,  length: { minimum: 3, maximum: 25 }
    validates :description,  length: {minimum: 6, maximum: 100}
    has_many :recipes, dependent: :destroy
    belongs_to :user


   def self.ransackable_attributes(auth_object = nil)
     ["created_at", "description", "id", "name", "updated_at", "user_id"]
   end

   def self.ransackable_associations(auth_object = nil)
      ["recipes", "user"]
    end
end
