class Recipe < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :ratings, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 10, maximum: 300}
    validates :preparation_steps, presence: true, length: {minimum: 10, maximum: 300}
    has_one_attached :file, dependent: :destroy
    has_many :favorites
    has_many :favorited_by, through: :favorites, source: :user

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "preparation_steps", "title", "updated_at", "user_id"]
  end
    def self.ransackable_associations(auth_object = nil)
    ["category"] # Add any other associations you want to allow for searching
  end
end
