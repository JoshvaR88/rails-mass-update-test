require 'spec_helper'

describe Book do
  it "updates nested attributes" do
    h2g2 = Book.new(title: "H2G2", price: 42)
    h2g2.save!
    h2g2.properties.create(key: "foo", value: "bar")
    h2g2.save!
    h2g2.reload
    h2g2.title.should eq "H2G2"
    puts h2g2.properties
  end
end

