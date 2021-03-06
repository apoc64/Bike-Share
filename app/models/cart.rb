class Cart
  attr_reader :contents

  def initialize(initial_contents)
  @contents = initial_contents
  end

  def total_count
    contents.values.sum
  end

  def add_accessory(id)
    if @contents[id.to_s]
      @contents[id.to_s] = @contents[id.to_s] + 1
    else
      @contents[id.to_s] = 1
    end
  end

  def decrease_accessory(id)
    @contents[id.to_s] = @contents[id.to_s] - 1
  end

  def total_cost
    @contents.keys.reduce(0) do |sum, item|
      sum + (Accessory.find(item.to_i).price * @contents[item])
    end
  end
end
