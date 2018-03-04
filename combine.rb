require "mini_magick"

def halt(message)
    print message, "\n"
    exit 1
end

halt '2 arguments expected' if ARGV.size != 2

fin = ARGV[0]
fout = ARGV[1]

halt 'Unable to find source file' unless File.exists?(fin)

halt 'Target file must not exist' if File.exists?(fout)


image  = MiniMagick::Image.new(fin)

`magick convert -size #{(image.width*2.5).round}x#{image.height*3} xc:white #{fout}`

result = MiniMagick::Image.new(fout)

w = image.width
dw = (image.width/6.0).round
h = image.height

2.times do |col|
  3.times do |row|
    result = result.composite(image) do |c|
      c.compose "Over"
      c.geometry "+#{col*(w + dw) + dw}+#{row*h}"
    end
  end
end



result.write(fout)