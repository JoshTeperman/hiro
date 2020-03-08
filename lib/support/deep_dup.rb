class Object
  def deep_dup
    dup
  end
end

class Array
  def deep_dup
    self.map(&:deep_dup)
  end
end

class Hash
  def deep_dup
    hash = Hash.new
    self.each_pair { |k, v| hash[k] = v.deep_dup }

    hash
  end
end
