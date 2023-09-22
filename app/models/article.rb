class Article < ApplicationRecord
  belongs_to :user
  validates :Title, presence:true, length: {minimum: 6,maximum:50}
  validates :Description, presence:true, length:{minimum: 6, maximum:500}
 
end
