require 'spec_helper'

describe Book do
  it "sets nested properties" do
    h2g2 = Book.create(title: "H2G2", price: 42, properties_attributes: {
      "0"=>{
        "key"=>"hello",
        "value"=>"123"
      }
    })
    h2g2.properties[0].key.should eq "hello"
  end

  it "should update multipe records" do
    book1 = create(:book, price: 12)
    book2 = create(:book, price: 13)
    Book.mass_update({
      :ids => [book1.id.to_s, book2.id.to_s],
      :book =>{
        :price => "42"
      }
    })

    book1.reload
    book2.reload

    book1.price.should eq 42
    book2.price.should eq 42
  end

  it "should add properties to multiple records" do
    book1 = create(:book)
    book2 = create(:book)
    Book.mass_update({
      :ids => [book1.id.to_s, book2.id.to_s],
      :book => {
        :properties_attributes => {
          "0" => {
            :key => "foo",
            :value => "bar"
          }
        }
      }
    })
    book1.reload
    book2.reload

    book1.properties.length.should eq 1
  end

  it "should updates and adds properties for multiple records" do
    book1 = create(:book, property_count: 1)
    book2 = create(:book)
    Book.mass_update({
      :ids => [book1.id.to_s, book2.id.to_s],
      :book => {
        :properties_attributes => {
          "0" => {
            :key => book1.properties[0].key,
            :value => "bar"
          }
        }
      }
    })
    book1.reload
    book2.reload

    book1.properties[0].value.should eq "bar"
    book2.properties[0].value.should eq "bar"
  end
end


