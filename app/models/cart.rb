class Cart

  attr_reader :contents 

  def initialize(contents)
    @contents = contents
  end

  def cart_count
    @contents.values.sum
  end

end
