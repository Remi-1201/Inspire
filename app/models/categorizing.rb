class Categorizing < ApplicationRecord
  belongs_to :blog, optional: true 
  belongs_to :category, optional: true 
end
