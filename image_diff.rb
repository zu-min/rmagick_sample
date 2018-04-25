require 'bundler/setup'
require 'rmagick'

img1 = Magick::Image.read('images/sample1.png').first
img2 = Magick::Image.read('images/sample2.png').first

img1.compare_channel(img2, Magick::MeanSquaredErrorMetric)[0].write('diff_images/sample_diff_1.png')
img1.composite(img2,Magick::NorthWestGravity,Magick::DifferenceCompositeOp).write('diff_images/sample_diff_2.png')

