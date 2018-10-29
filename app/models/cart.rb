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

  def cart_item_total
    hash = {}
    @contents.keys.each do |id|
      hash[id] = (contents[id] * Item.find(id).price)
    end
    return hash
  end

end
