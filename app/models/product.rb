class Product < ApplicationRecord
  belongs_to :recommender
  belongs_to :topic
end