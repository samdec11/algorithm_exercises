class NewHash
  attr_accessor :backing

  Pair = Struct.new(:key, :value)

  def initialize(size=8)
    @backing = Array.new(size, [])
  end

  def put(key, value)
    bucket = find_bucket(key)
    result = bucket.any? do |pair|
      if pair.key.eql?(key)
        pair.value = value
        return true
      end
    end
    bucket << Pair.new(key, value) unless result
  end

  def get(key)
    bucket = find_bucket(key)
    bucket.detect{|pair| pair.key.eql?(key) }&.value
  end

  private

  def find_bucket(key)
    hsh = key.hash % backing.size
    backing[hsh]
  end
end
