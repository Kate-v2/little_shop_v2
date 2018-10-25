FactoryBot.define do
  factory :user do
    name { "George"}
    city { "Denver"}
    state { "CO"}
    address { "482 Pearl St"}
    zip { 80203}
    email { "George@mail.com"}
    password_digest {"secure"}
    role {1}
    active {true}
  end
end
