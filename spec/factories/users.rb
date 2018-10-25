FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "name #{n}"}
    sequence(:address) {|n| "#{10*n} Address Lane"}
    sequence(:city) {|n| "city #{n}" }
    sequence(:state) {|n| "state #{n}" }
    sequence(:zip) {|n| 10*n }
    sequence(:email) {|n| "email #{n}" }
    sequence(:password) {|n| "password#{n}" }
    sequence(:role) {|n| 0 }
    sequence(:active) {|n| 1 }
  end
end
