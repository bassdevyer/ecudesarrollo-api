require 'rails_helper'

RSpec.describe Person, type: :model do
  # ensure columns title and created_by are present before saving
  it {should validate_presence_of(:dni)}
  it {should validate_presence_of(:names)}
  it {should validate_presence_of(:surnames)}
end
