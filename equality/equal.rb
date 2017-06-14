class Item
  attr_reader :name, :calories, :ingredients

  def initialize(name, calories, ingredients)
    @name = name
    @calories = calories
    @ingredients = ingredients
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(Item)
    name == other.name && calories == other.calories && ingredients == other.ingredients
  end

  def eql?(other)
    self == other
  end
end

class Ingredient
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other&.name
  end

  def eql?(other)
    self == other
  end
end
