class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item)
    @contents[item] = count_of(item) + 1
  end

  def count_of(item)
    @contents[item].to_i
  end
end
