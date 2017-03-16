module UserFilesHelper
  def icon_for_file file
    case file
    when /pdf$/i
      'fa-file-pdf-o'
    when /(png|jpg|jpeg)/i
      'fa-file-image-o'
    end
  end
end
