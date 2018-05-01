require 'bundler/setup'
require 'rmagick'

class ImageDiff
  attr_reader :img1, :img2

  def initialize(file1, file2)
    @img1 = Magick::Image.read(file1).first
    @img2 = Magick::Image.read(file2).first
  end

  def save(path)
    exec.write(path)
  end

  private
  def exec
    img1.compare_channel(img2, Magick::MeanSquaredErrorMetric).first
  end
end

image = ImageDiff.new('images/sample1.png','images/sample2.png')
image.save('diff_images/sample_diff_1.png')

