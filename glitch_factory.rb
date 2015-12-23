require 'pnglitch'

filters = [:optimized, :sub, :up, :average, :paeth]
methods = [:replace, :transpose, :defect, :graft]

# consider using ARGV
def set_params(filters, methods)
  puts "Input path to png file:"
  path = gets.chomp()
  if (path == "" || path.length <= 4)
    puts "...invalid path"
    return
  end
  puts "Select Filter:"
  filters.each_with_index do |filter, index|
    puts "#{index + 1}. #{filter}"
  end
  selection = gets.chomp().to_i
  filter = filters[selection - 1]
  if (selection > filters.length)
    puts "...invalid filter"
    return
  end
  puts "Select Method:"
  methods.each_with_index do |filter, index|
    puts "#{index + 1}. #{filter}"
  end
  selection = gets.chomp().to_i
  method = methods[selection - 1]
  if (selection > methods.length)
    puts "...invalid filter"
    return
  end
  puts "You selected Filter: #{filter}, and Method: #{method}. Y/N"
  cta = gets.chomp();
  if cta.upcase == "Y"
    if (path && filter && method)
      glitch_factory(path, filter, method)
    else
      puts "Sorry mate"
    end
  else
    return
  end
end

def glitch_factory(path, filter, method)
  count = 0
  [false, true].each do |compress|
    if compress && method == :graft
      return
    end
    count += 1
    # png instance
    png = PNGlitch.open path
    # set filter
    png.change_all_filters filter unless filter == :optimized
    # print glitch options
    options = [filter.to_s]
    options << method.to_s
    options << 'compress' if compress
    # define new file
    outfile = "NWA-#{count}-#{options}.png"
    puts outfile
    # assign methods
    process = lambda do |data, range|
      case method
      when :replace
        range.times do
          data[rand(data.size)] = 'x'
        end
        data
      when :transpose
        x = data.size / 4
        data[0, x] + data[x * 2, x] + data[x * 1, x] + data[x * 3..-1]
      when :defect
        (range / 5).times do
          data[rand(data.size)] = ''
        end
        data
      when :graft
        png.each_scanline do |line|
          line.graft rand(range)
        end
        png
      end
    end
    # process png
    unless compress
      if method == :graft
        process.call png, 5
      else
        png.glitch do |data|
          process.call data, 50
        end
      end
    else
      png.glitch_after_compress do |data|
        process.call data, 10
      end
    end
    ##save png
    png.save outfile
    png.close
  end
end

set_params(filters, methods)
