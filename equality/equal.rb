class Item
  attr_reader :name, :calories, :ingredients

  def initialize(name, calories, ingredients = [])
    @name = name
    @calories = calories
    @ingredients = ingredients
  end

  def ==(other)
    return true if self.equal?(other)
    return false if other.nil? || !other.is_a?(Item)
    name == other.name && calories == other.calories && ingredients_match(other.ingredients)
  end

  def eql?(other)
    self == other
  end

  def hash
    result = name.hash
    result = 31 * name.hash + calories
    result = 31 * result + ingredients.hash
    result
  end

  private

  def ingredients_match(other_ingredients) # assumes there are no duplicates
    ingredients.all? { |ingredient| other_ingredients.include?(ingredient) } &&
    other_ingredients.all? { |ingredient| ingredients.include?(ingredient) }
  end
end

class Ingredient
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(Ingredient)
    name == other.name
  end

  def eql?(other)
    self == other
  end

  def hash
    31 * name.hash
  end
end
