class MassFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, :check_box_tag, :hidden_field_tag,  to: :@template

  %w[text_field text_area password_field datetime_select date_select number_field check_box select collection_select].each do |method_name|
    define_method(method_name) do |name, *args|
      if field_requires_uniqueness(name)
        "This field needs to be unique so it cannot be mass edited."
      else
        super(name, *args)
      end
    end
  end

  def label(name, *args)
    if field_requires_value(name)
      super(name, *args)
    else
      super(name, *args) + check_box_tag("_null", "#{object_name}_#{name}")  + " Clear " + hidden_field_tag("#{object_name}[#{name}]", "", {:disabled => "disabled"})
    end
  end

  private

  def field_requires_uniqueness(name)
    object.class.validators_on(name).any? { |a| a.kind_of? ActiveRecord::Validations::UniquenessValidator }
  end
    
  def field_requires_value(name)
    object.class.validators_on(name).any? { |a| a.kind_of? ActiveModel::Validations::PresenceValidator }
  end

end

