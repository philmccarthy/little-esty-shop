require 'rails_helper'

RSpec.describe BulkDiscount, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:pct_discount).only_integer.is_less_than(100).is_greater_than_or_equal_to(5) }
    it { should validate_numericality_of(:min_qty).only_integer.is_greater_than(1) }
  end

  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'instance methods' do
  end
end