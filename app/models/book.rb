class Book < ActiveRecord::Base
  attr_accessible :price, :title, :properties_attributes

  validates :title, :uniqueness => true

  has_many :properties

  accepts_nested_attributes_for :properties

  def autosave_associated_records_for_properties
    logger.debug "autosave_associated_records_for_properties called"
    properties.each do |property|
      match = Property.find_by_key_and_book_id(property.key, self.id)
      if match
        # Already exists, so update
        logger.debug "Property already exists"
        match = property
        match.save!
      else
        logger.debug "Property does not exists"
        # Doesn't exist. so create
        property.save!
      end

    end
  end

end

