module FiltersHelper
  def format_filters(f)
    x = f.symbolize_keys[:pre].map do |key, value|
      next if value.to_s.empty?
      "#{key.capitalize} = #{value.inspect}"
    end.compact
    if r = f.symbolize_keys[:post] or not r == //.to_s
      "REGEXP = #{r}"
    end
    x
  end
end
