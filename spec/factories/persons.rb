FactoryBot.define do
  factory :person do
    dni {Faker::IDNumber.valid}
    names {Faker::Name.first_name + Faker::Name.middle_name}
    surnames {Faker::Name.last_name + Faker::Name.last_name}
    birth_date {Faker::Date.birthday(18, 65)}
    address {Faker::Address.full_address}
    phone {Faker::PhoneNumber.phone_number}
    mobile {Faker::PhoneNumber.cell_phone}
    email {Faker::Internet.email}
  end
end