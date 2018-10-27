class Cart

  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def cart_count 
    @contents.values.sum
  end

  def cart_items
    item_ids = @contents.keys
    items = Item.where(id: item_ids)
  end

end
