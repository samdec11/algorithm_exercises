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
    find_pair_by_key(key)&.value
  end

  def contains?(key)
    !!find_pair_by_key(key)
  end

  private

  def find_bucket(key)
    hsh = key.hash % backing.size
    backing[hsh]
  end

  def find_pair_by_key(key)
    bucket = find_bucket(key)
    bucket.detect{ |pair| pair.key.eql?(key) }
  end
end
