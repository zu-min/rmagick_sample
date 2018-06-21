require './lib/image_diff'

today = Date.parse('20180517').strftime("%Y%m%d")
yesterday = (Date.parse(today) - 1).strftime("%Y%m%d")

file_name = File.read('images/filelist.txt').split(/\R/)

file_name.each do |f|
  old_image_name = "images/#{today}/#{f}"
  new_image_name = "images/#{yesterday}/#{f}"

  if File.exist?(old_image_name) && File.exist?(new_image_name)
    diff_image = ImageDiff.new(old_image_name, new_image_name)
    diff_image.save("#{f}")
  else
    puts "Not Found: #{old_image_name}"
  end
end

