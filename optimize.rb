require 'image_optim'
require 'image_optim_pack'


image_optim = ImageOptim.new

image_optim = ImageOptim.new(:pngout => false)

image_optim = ImageOptim.new(:nice => 20)

image_optim.optimize_images(Dir['*.png']) do |unoptimized, optimized|
  if optimized
    puts "#{unoptimized} => #{optimized}"
  end
end
