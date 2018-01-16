FactoryBot.define do
  factory :order do
    customer_name "MyText"
    fulfilled false
    item "MyText"
    quantity 1
    pick_up_at "2018-01-16 09:07:02"
  end
end
