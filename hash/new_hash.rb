class NewHash
  attr_accessor :backing

  Pair = Struct.new(:key, :value)

  def initialize(size=8)
    @backing = Array.new(size, [])
  end

  def put(key, value)
    hsh = key.hash % backing.size
    bucket = backing[hsh]
    result = bucket.any? do |pair|
      if pair.key.eql?(key)
        pair.value = value
        return true
      end
    end
    bucket << Pair.new(key, value) unless result
  end
end
