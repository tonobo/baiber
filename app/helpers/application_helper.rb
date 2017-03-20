module ApplicationHelper
  def file_group_labels(user_file_groups)
    [user_file_groups].flatten.map do |x|
      content_tag(:span, style: "background-color: #{x.color}", 
                  class: 'label') { x.name }
    end.join
  end
end
