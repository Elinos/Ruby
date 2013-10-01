class Player
  @hit_wall =  false
  @pivot = false
  def play_turn(warrior)
    unless @hit_wall
      if warrior.feel(:backward).captive?
        warrior.rescue! :backward
      elsif warrior.feel(:backward).enemy?
        unless @pivot
          warrior.pivot!
          @pivot = true
        else
          warrior.attack!
        end
      elsif warrior.health < 20 && @health <= warrior.health
        warrior.rest!
      elsif warrior.feel(:backward).empty?
        warrior.walk! :backward
      elsif warrior.feel(:backward).wall?
        @hit_wall = true;
      end
    else
      if warrior.feel.captive?
        warrior.rescue!
      elsif warrior.feel.enemy?
        warrior.attack!
      elsif @health > warrior.health && warrior.health < 10
        warrior.walk! :backward
      elsif warrior.health < 20 && @health <= warrior.health
        warrior.rest!
      elsif warrior.feel.empty?
        warrior.walk!
        change
      end
    end
    @health = warrior.health
  end
end
