class Object
  def deep_dup
    dup
  end
end

class Array
  def deep_dup
    map { |element| element == self ? self : element.deep_dup }
  end
end

class Hash
  def deep_dup
    hash = {}
    each_pair { |key, value| hash[key] = value == self ? self : value.deep_dup }

    hash
  end
end
