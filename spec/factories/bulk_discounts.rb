FactoryBot.define do
  factory :bulk_discount do
    min_qty { %w[ 10 25 50 75 ].sample }
    pct_discount { %w[ 10 20 30 40 50 ].sample }
  end
end