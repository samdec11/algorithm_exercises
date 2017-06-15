require_relative "./equal"

RSpec.describe Ingredient do
  let(:one) { described_class.new("a") }
  let(:two) { described_class.new("b") }
  let(:three) { described_class.new("a") }

  describe "#eql?" do
    it "is true when one object has the same name as another" do
      expect(one.eql?(three)).to be true
    end

    it "is false when one object does not have the same name as another" do
      expect(one.eql?(two)).to be false
    end

    it "is false when the object being compared to is not an Ingredient" do
      NonIngredientClass = Struct.new(:name)
      four = NonIngredientClass.new("a")

      expect(one.eql?(four)).to be false
    end
  end
end

RSpec.describe Item do
  let(:sugar) { Ingredient.new("Sugar") }
  let(:cocoa) { Ingredient.new("Cocoa") }
  let(:cocoa_butter) { Ingredient.new("Cocoa Butter") }
  let(:dark_chocolate_ingredients) { [sugar, cocoa, cocoa_butter] }
  let(:dark_chocolate) { described_class.new("Chocolate", 200, dark_chocolate_ingredients) }

  let(:brown_sugar) { Ingredient.new("Sugar") }
  let(:chocolate_ingredients) { [brown_sugar, cocoa, cocoa_butter] }
  let(:chocolate) { described_class.new("Chocolate", 200, chocolate_ingredients) }

  let(:more_chocolate) { described_class.new("Chocolate", 200, chocolate_ingredients) }

  let(:salt) { Ingredient.new("Salt") }
  let(:almonds) { Ingredient.new("Almonds") }
  let(:salted_almonds) { described_class.new("Almonds", 100, [almonds, salt]) }

  describe "#eql?" do
    it "is true in the case of reflexivity" do
      expect(chocolate.eql?(chocolate)).to be true
    end

    it "is true in the case of symmetry" do
      expect(chocolate.eql?(dark_chocolate)).to be true
      expect(dark_chocolate.eql?(chocolate)).to be true
    end

    it "is true in the case of transitivity" do
      expect(chocolate.eql?(dark_chocolate)).to be true
      expect(dark_chocolate.eql?(more_chocolate)).to be true
      expect(more_chocolate.eql?(chocolate)).to be true
    end

    it "is true in the case of consistency" do
      expect(chocolate.eql?(chocolate) && chocolate.eql?(chocolate)).to be true
    end

    it "is true when the items match, regardless of order" do
      ordered_ingredients = [cocoa_butter, cocoa, brown_sugar]
      even_more_chocolate = described_class.new("Chocolate", 200, ordered_ingredients)

      expect(chocolate.eql?(even_more_chocolate)).to be true
    end

    it "is false when compared to nil" do
      expect(chocolate.eql?(nil)).to be false
    end

    it "is false when attributes are different" do
      expect(chocolate.eql?(salted_almonds)).to be false
    end

    it "is false when the object being compared to is not an Item" do
      NonItemClass = Struct.new(:name, :calories, :ingredients)
      not_item = NonItemClass.new("Chocolate", 200, chocolate_ingredients)

      expect(chocolate.eql?(not_item)).to be false
    end
  end
end
