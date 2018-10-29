FactoryBot.define do


  factory :item do
    sequence(:name)        {|n| "Item #{n}"}
    sequence(:price)       {|n| n * 10}
    sequence(:description) {|n| "text #{n}" }
    sequence(:inventory)   {|n| n * 100 }
    sequence(:active)      {|n| 1 }
    sequence(:user_id)     {nil}
  end

end
