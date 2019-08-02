#!/usr/bin/env ruby
# vim:sw=2:ts=2:expandtab:syn=ruby

# Simulate a Minecraft Enchant Table
# https://minecraft.gamepedia.com/Tutorials/Enchantment_mechanics

def max(a,b)
  (a>b) ? a : b
end

def min(a,b)
  (a<b) ? a : b
end

def base_enchant(active_books, gui_slot)
  base = (rand(8)+1) + (active_books/2) + rand(active_books).to_i
  case gui_slot
  when 1, :top
    max(base / 3, 1)
  when 2, :middle
    base * 2 / 3 + 1
  when 3, :bottom
    max(base, active_books*2)
  else
    -1
  end
end

def print_base_enchant
  (0..15).each do |b|
    [:top, :middle, :bottom].each do |s|
      (1..100).each do
        puts "(#{b},#{s}) => #{base_enchant(b,s)}"
      end
    end
  end
end
#print_base_enchant

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

def print_enchantibility_table
  [:armor,:tool].each do |i|
    [:wood,:leather,:stone,:iron,:chain,:diamond,:gold,:book].each do |m|
      puts "#{i},#{m} => #{enchantablity(m,i)}"
    end
  end
end
#print_enchantibility_table

def r (e)
  rand(e/4+1)
end

bookshelves = 15 # 0 to 15
slot = 3 # 1(:top), 3(:middle), 3(:bottom)
#e=enchantablity(:iron, :armor)
e=enchantablity(:diamond, :armor)
e=enchantablity(:iron, :tool)
b=base_enchant(bookshelves, slot)

(0..9).each do
ri1=r(e)
ri2=r(e)
l = b + ri1 + ri2 + 1

rf1=rand
rf2=rand
rand_bonus_percent = 1 + ( rf1 + rf2 - 1) * 0.15

final_level = max( (l * rand_bonus_percent).to_i, 1)

#        f = ( b +  r +  r + 1 ) * ( 1 + (   r +   r - 1 ) * 0.15 ) 
printf '%i = (%i + %i + %i + 1 ) * ( 1 + ( %3f + %3f - 1 ) * 0.15 )%s', \
  final_level, b, ri1, ri2, rf1, rf2, "\n"

end
