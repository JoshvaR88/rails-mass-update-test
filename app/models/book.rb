class Book < ActiveRecord::Base
  attr_accessible :price, :title, :notes, :properties_attributes

  validates :title, :uniqueness => true

  has_many :properties

  accepts_nested_attributes_for :properties

  def self.mass_update(params)
    books = find(params[:ids])

    #params[:book].delete_if {|k,v| v.empty?}
    params[:book].delete_if {|k,v| Book.validators_on(k).any? { |v| v.kind_of? ActiveRecord::Validations::UniquenessValidator }}

    book_params = params[:book].except(:properties_attributes)
    property_params = params[:book][:properties_attributes]

    books.each do |book|
      book.update_attributes(book_params)
      book.add_or_update_properties(property_params)
    end
  end

  def add_or_update_properties(property_params)
    if !property_params.nil?
      property_params.each_pair do |id, attributes|
        property = Property.find_by_key_and_book_id(attributes[:key], self.id)
        if property.nil?
          properties << Property.new(attributes)
          save!
        else
          property.update_attributes(attributes)
        end
      end
    end
  end
end

