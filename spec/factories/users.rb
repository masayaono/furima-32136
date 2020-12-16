FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password { Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name {"真弥"}
    family_name {"小野"}
    first_name_kana {"マサヤ"}
    family_name_kana {"オノ"}
    birth_strftime {Faker::Date.in_date_period }
  end
end