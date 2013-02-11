class MassFormBuilder < ActionView::Helpers::FormBuilder
  %w[text_field text_area password_field datetime_select date_select number_field check_box select collection_select].each do |method_name|
    define_method(method_name) do |name, *args|
      if object.class.validators_on(name).any? { |a| a.kind_of? ActiveRecord::Validations::UniquenessValidator }
        "This field needs to be unique so it cannot be mass edited."
      else
        super(name, *args)
      end
    end
  end
end

