require 'bundler/setup'
require 'rmagick'
require 'date'

class ImageDiff
  attr_reader :old_image, :new_image, :diff, :image_pixels

  def initialize(file1, file2)
    @old_image = Magick::Image.read(file1).first
    @new_image = Magick::Image.read(file2).first
    @image_pixels = new_image.columns * new_image.rows
  end

  def save(path, threshold=0.05)
    if percent > threshold
      diff.write('error_images/' + path)
      puts "Error: #{path}"
    else
      diff.write('standard_images/' + path)
      puts "Standard: #{path}"
    end
  end

  private
  def percent
    diff_percent = (100 - count_diff_pixels/image_pixels.to_f*100).round(3)
    puts "#{diff_percent} %"

    diff_percent
  end

  def count_diff_pixels
    exec
    diff_image = diff.get_pixels(0, 0, diff.columns, diff.rows)
    diff_image.select { |item| item.red == 0 && item.green == 0 && item.blue == 0}.count
  end

  def exec
    @diff = old_image.composite(new_image, Magick::NorthWestGravity, Magick::DifferenceCompositeOp)
  end
end

