#!/usr/bin/env ruby
# vim:sw=2:ts=2:expandtab:syn=ruby

# Simulate a Minecraft Enchant Table
# https://minecraft.gamepedia.com/Tutorials/Enchantment_mechanics

bookshelves = 15 # 0 to 15
slot = 3 # 1(top) to 3(bottom)

def max(a,b)
  (a>b) ? a : b
end

def min(a,b)
  (a<b) ? a : b
end

def base_enchant(books, slot)
  base = (rand(8)+1) + (books/2) + rand(books).to_i
  case slot
  when 1, :top
    max(base / 3, 1)
  when 2, :middle
    base * 2 / 3 + 1
  when 3, :bottom
    max(base, books*2)
  else
    -1
  end
end

# "commented out" testing code
if nil
(0..15).each do |b|
  [:top, :middle, :bottom].each do |s|
    (1..100).each do
      puts "(#{b},#{s}) => #{base_enchant(b,s)}"
    end
  end
end
end


def enchantablity (material, item)

  item = :tool if item == :sword
  case [material, item]
  when [:wood, :tool]
    15
  when [:leather, :armor]
    15
  when [:stone, :tool]
    5
  when [:iron, :armor]
    9
  when [:iron, :tool]
    14
  when [:chain, :armor]
    12
  when [:diamond, :armor], [:diamond, :tool]
    10
  when [:gold, :armor]
    25
  when [:gold, :tool]
    22
  when [:book, :armor], [:book, :tool]
    1
  else
    -1
  end
end

# "commenting" out more debugging code
if nil
[:armor,:tool].each do |i|
  [:wood,:leather,:stone,:iron,:chain,:diamond,:gold,:book].each do |m|
    puts "#{i},#{m} => #{enchantablity(m,i)}"
  end
end
end

def r (e)
  rand(e/4+1)
end

#e=enchantablity(:iron, :armor)
e=enchantablity(:diamond, :armor)
e=enchantablity(:iron, :tool)
b=base_enchant(15,3) # max enchant, for now at least

(0..999).each do
  ri1=r(e)
  ri2=r(e)
l = b + ri1 + ri2 + 1
#puts "L(#{l}) = B(#{b}) + R1(#{ri1}) + R2(#{ri2}) + 1; E=#{e}"

rf1=rand
rf2=rand

rand_bonus_percent = 1 + ( rf1 + rf2 - 1) * 0.15
final_level = max( (l * rand_bonus_percent).to_i, 1)
#puts "FINAL(#{final_level}) = L(#{l}) * (1 + ( RF1(#{rf1}) + RF2(#{rf2}) - 1 ) * .015)"

printf '%i = (%i + %i + %i + 1 ) x ( 1 + ( %3f + %3f -1 ) x 0.015 ) %s', \
  final_level, b, ri1, ri2, rf1, rf2, "\n"

# f = (b +r + r + 1 ) * ( 1 + ( r + r - 1 ) * .015 ) 
end
