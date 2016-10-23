#!/usr/bin/env ruby -w

# Created: 2016-10-22, Thomas Billicsich - pixlig
# Description: Takes two images, scans for an overlap and
#               merges them above each other


require 'rmagick'
include Magick


if ARGV.length != 2
  puts "Image Stitcher: did not supply two arguments, using example files."
  puts "Provided args: #{ARGV.length}"
  ARGV.each do |arg|
    puts "ARGV: " + arg
  end

  img_above = Image.read('example/above.png').first
  img_below = Image.read('example/below.png').first
  working_dir = File.dirname('example/below.png')
else
  puts "1: " + ARGV[0]
  puts "2: " + ARGV[1]

  img_above = Image.read(ARGV[0]).first
  img_below = Image.read(ARGV[1]).first
  working_dir = File.dirname(ARGV[0])
end

output_filename = 'stitched_image.png'

number_of_comparison_rows = 10
image_width = img_below.columns
first_row_of_img_below = img_below.crop(0, 0, image_width, number_of_comparison_rows)

# 1. Iterate over the above image until a similar row is detected
# 2. Concatenate the two images
#   a. Create a new image with the width of the img_above
#   b. Copy cropped img_above to 0,0
#   c. Copy img_below to 0,height of cropped img_above
# 3. Write out new image

# Step 1
num_of_topmost_similar_row = false
current_row_num = 0

while !num_of_topmost_similar_row do
  current_row = img_above.crop(0, current_row_num, image_width, number_of_comparison_rows)
  difference = current_row.difference(first_row_of_img_below)
  if difference[2] < 0.01
    num_of_topmost_similar_row = current_row_num
  end
  current_row_num += 1

  # Todo: Check for boundary 
end

# print difference.to_s + "\n"
# current_row.write("similar_region.png")

# Step 2
stitched_image = Image.new(image_width, current_row_num + img_below.rows)

stitched_image = stitched_image.composite(img_above, 0, 0, OverCompositeOp)
.composite(img_below, 0, num_of_topmost_similar_row, OverCompositeOp)

stitched_image.write(working_dir + '/' + output_filename)

exit
