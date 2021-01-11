class checkout

  def initialize(content)
    @content = content
  end

  def find_items
    Item.where(id: @content.keys)
  end
end
