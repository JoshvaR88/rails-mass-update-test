FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "Book Title #{n}" }
    price 42
    
    ignore do
      property_count 0
    end
    after(:create) do |book, evaluator|
      FactoryGirl.create_list(:property, evaluator.property_count, book: book)
    end
  end
end

