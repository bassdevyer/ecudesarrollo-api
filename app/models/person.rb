class Person < ApplicationRecord
  validates_presence_of :dni, :names, :surnames
end
