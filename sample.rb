require 'bundler/setup'
require 'rmagick'
require 'date'

class ImageDiff
  attr_reader :img, :diff

  def initialize(file)
    @img = Magick::Image.read(file).first
  end

  def percent
    p img
    # puts img.get_pixels(0, 0, img.columns, img.rows)
    diff_image = img.get_pixels(0, 0, img.columns, img.rows)
    diff_pixel_count = diff_image.select { |item| item.red == 0 && item.green == 0 && item.blue == 0}.count
    pixels = img.columns * img.rows
    puts diff_pixel_count
    puts pixels
    puts "#{(100 - diff_pixel_count/pixels.to_f*100).round(3)}%"
  end
end

image = ImageDiff.new('standard_images/sample1.png')
image.percent

image = ImageDiff.new('standard_images/sample4.png')
image.percent

