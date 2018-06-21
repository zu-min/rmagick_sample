require 'bundler/setup'
require 'rmagick'
require 'date'

class ImageDiff
  attr_reader :img1, :img2, :diff, :diff2

  def initialize(file1, file2)
    @img1 = Magick::Image.read(file1).first
    @img2 = Magick::Image.read(file2).first
  end

  def save(path)
    # p img1
    # puts img1.get_pixels(0, 0, 124, 95)
    # puts img1.get_pixels(0, 0, 124, 95).select { |item| item.red == 61423 && item.green == 4626 && item.blue == 15677}
    p img1.difference(img2)
    # img1.compare_channel(img2, Magick::MeanSquaredErrorMetric).first.write('diff_images/sample1.png')
    img1.composite(img2, Magick::NorthWestGravity, Magick::DifferenceCompositeOp).write(path)
  end
end

file_name = 'sample4.png'
image = ImageDiff.new("images/20180516/#{file_name}", "images/20180517/#{file_name}")
image.save("diff_images/#{file_name}")
