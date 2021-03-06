require_relative "./new_hash"

RSpec.describe NewHash do
  let(:my_hash) { described_class.new }

  describe "#put" do
    let(:key) { "one" }
    let(:value) { 1 }

    it "adds the pair to the backing of the hash" do
      pair = put_in_hash(my_hash, key, value, 0)

      expect(pair.key).to eq(key)
      expect(pair.value).to eq(value)
    end

    it "replaces the value if a new pair is added with the same key" do
      put_in_hash(my_hash, key, value)
      pair = put_in_hash(my_hash, key, 2, 0)

      expect(pair.key).to eq(key)
      expect(pair.value).to eq(2)
    end

    it "adds to a bucket inside of the backing when two keys have the same hashcode calculation" do
      second_key = "two"
      allow(second_key).to receive(:hash).and_return(key.hash)
      pair_one = put_in_hash(my_hash, key, value, 0)
      pair_two = put_in_hash(my_hash, second_key, 3, 1)

      expect(pair_one.key).to eq(key)
      expect(pair_one.value).to eq(value)
      expect(pair_two.key).to eq(second_key)
      expect(pair_two.value).to eq(3)
    end
  end

  describe "#get" do
    let(:key) { "red" }
    let(:value) { "#FF0000" }
    it "returns the value of the given key if it exists in the backing" do
      put_in_hash(my_hash, key, value)
      expect(my_hash.get(key)).to eq(value)
    end

    it "returns nil if the key does not exist in the backing" do
      expect(my_hash.get(key)).to be_nil
    end
  end

  describe "#contains?" do
    let(:key) { "green" }
    let(:value) { "#00FF00" }

    it "returns true if the given key is stored in the backing" do
      put_in_hash(my_hash, key, value)
      expect(my_hash.contains?(key)).to eq(true)
    end

    it "returns false if the given key is not stored in the backing" do
      expect(my_hash.contains?(key)).to eq(false)
    end
  end
end

def put_in_hash(hsh, key, value, position = nil)
  bucket = key.hash % hsh.backing.size
  hsh.put(key, value)
  hsh.backing[bucket][position] if position
end
