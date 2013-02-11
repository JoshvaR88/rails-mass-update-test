class Property < ActiveRecord::Base
  belongs_to :book
  attr_accessible :key, :value, :book_id

  validates :key, :presence => true, :uniqueness => {:scope => :book_id}
  validates :value, :presence => true
  validates :book, :presence => true
end

