class Article < ApplicationRecord
  validates :Title, presence:true, length: {minimum: 6,maximum:50}
 validates :Description, presence:true, length:{minimum: 6, maximum:500}
 
end
