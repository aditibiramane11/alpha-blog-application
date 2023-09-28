class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :Title, presence:true, length: {minimum: 6,maximum:50}
  validates :Description, presence:true, length:{minimum: 6, maximum:500}
 
end
