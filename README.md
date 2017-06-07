# image-stitcher
A script that stitches two images vertically together - very handy
for merging screenshots of a webpage.



## Usage
run with `ruby image_stitcher.rb <image1> <image2>`.

The two images need to have a vertical section which overlaps. The script
scans for the overlap and merges the images so that one seamless image
results.

### Platypus
To use the script on macOS by dragging two images onto it, use e.g. Platypus,
a bash script is included in this rep.

## Dependencies
This script ist tested with ruby 2.2.3. It requires the gem `rmagick`. rmagick
requires ImageMagick, e.g. installed with homebrew.

## Internal Notes
* Docs for RMagick are here: https://rmagick.github.io/index.html
