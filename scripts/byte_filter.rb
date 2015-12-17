require 'pnglitch'

PNGlitch.open('../source_png/Chapterhouse.png') do |p|
  p.change_all_filters 2
  p.each_scanline do |l|
    l.register_filter_encoder do |data, prev|
      data.size.times.reverse_each do |i|
        x = data.getbyte(i)
        v = prev ? prev.getbyte(i) : 0
        data.setbyte(i, (x - v) & 0xfe)
      end
      data
    end
  end
  p.save '../glitch_png/byte_filter.png'
end
