FactoryGirl.define do
  factory :property do
    sequence(:key) {|n| "key#{n}" }
    sequence(:value) {|n| "value#{n}" }
    book
  end
end

