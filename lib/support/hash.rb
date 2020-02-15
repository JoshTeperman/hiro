class Hash
  def symbolize_keys
    transform_keys { |key| key.to_sym rescue key }
  end

  def deep_symbolize_keys
    deep_transform_keys { |key| key.to_sym rescue key }
  end

  private

  def deep_transform_keys(&block)
    deep_transform_keys_in_object(self, &block)
  end

  def deep_transform_keys_in_object(object, &block)
    case object
    when Hash
      object.each_with_object({}) do |(key, value), result|
        result[yield(key)] = deep_transform_keys_in_object(value, &block)
      end
    when Array
      object.map { |element| deep_transform_keys_in_object(element, &block) }
    else
      object
    end
  end
end
