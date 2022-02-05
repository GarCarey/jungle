require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "will validate if all vaildations are inputted" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: "g@c.com", password: "12345678", password_confirmation: "12345678")
      user.save

      expect(user).to be_valid
    end

    it "will not vaildate with no first name" do
      user = User.new(first_name: nil, last_name: "Carey", email: "g@c.com", password: "12345678", password_confirmation: "12345678")
      user.save

      expect(user.errors.full_messages).to be == ["First name can't be blank"]
    end

    it "will not validate with no last name" do
      user = User.new(first_name: "Gar", last_name: nil, email: "g@c.com", password: "12345678", password_confirmation: "12345678")
      user.save

      expect(user.errors.full_messages).to be == ["Last name can't be blank"]
    end

    it "will not validate with no email" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: nil, password: "12345678", password_confirmation: "12345678")
      user.save

      expect(user.errors.full_messages).to be == ["Email can't be blank"]
    end

    it "will not validate with if password has already been used" do
      user1 = User.new(first_name: "Gar", last_name: "Carey", email: "g@c.com", password: "12345678", password_confirmation: "12345678")
      user1.save
      
      user2 = User.new(first_name: "Gar", last_name: "C", email: "g@c.com", password: "12345678", password_confirmation: "12345678")
      user2.save

      expect(user2.errors.full_messages).to be == ["Email has already been taken"]
    end

    it "will  validate with if email has spaces around it" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: " g@c.com ", password: "12345678", password_confirmation: "12345678")
      user.save

      expect(user.email).to be == "g@c.com"
    end

    it "will not validate with if password is blank" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: " g@c.com ", password: nil, password_confirmation: nil)
      user.save

      expect(user.errors.full_messages).to be == ["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 8 characters)"]
    end

    it "will not validate with if password confirmation is blank" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: "g@c.com", password: "12345678", password_confirmation: nil)
      user.save

      expect(user.errors.full_messages).to be == ["Password confirmation doesn't match Password"]
    end

    it "will not validate with if password is not at least 8 characters" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: "g@c.com", password: "123", password_confirmation: "123")
      user.save

      expect(user.errors.full_messages).to be == ["Password is too short (minimum is 8 characters)"]
    end
  end

  describe ".authenticate_with_credentials" do
    it "will return nil if no user is found" do
      result = User.authenticate_with_credentials("c@g.com", "12345678")

      expect(result).to be_nil
    end

    it "will return user if user is found" do
      user = User.new(first_name: "Gar", last_name: "Carey", email: "g@c.com", password: "12345678", password_confirmation: "12345678")
      user.save

      result = User.authenticate_with_credentials("g@c.com", "12345678")

      expect(result).to be == user
    end
  end
  
end