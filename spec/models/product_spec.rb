require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "will save if all vaildations are inputted" do
      product = Product.new(name: "Shower radio", price: 20, quantity: 10, category: Category.new(name: "Gadgets"))

      expect(product).to be_valid
    end

    it "will not save if name is not present" do
      product = Product.create(name: nil, price: 20, quantity: 10, category: Category.new(name: "Gadgets"))

      expect(product.errors.full_messages).to be == ["Name can't be blank"]
    end

    it "will not save if price is not present" do
      product = Product.create(name: "Shower Radio", price: nil, quantity: 10, category: Category.new(name: "Gadgets"))
      
      expect(product.errors.full_messages).to be == []
    end

    it "will not save if quantity is not present" do
      product = Product.create(name: "Shower Radio", price: 20, quantity: nil, category: Category.new(name: "Gadgets"))
      
      expect(product.errors.full_messages).to be == ["Quantity can't be blank"]
    end

    it "will not save if category is not present" do
      product = Product.create(name: "Shower Radio", price: 20, quantity: 10, category: nil)
      
      expect(product.errors.full_messages).to be == ["Category can't be blank"]
    end

  end
end