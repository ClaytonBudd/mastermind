class Mastermind
  def initialize
    @key = []
    @guess = []
    @feedback = []
    @turn = 1
  end

  def color_pos_match?(_key, guess) 
    check_key = @key.clone
    @guess.zip(check_key).each do |guess, key|
      if guess == key
        @guess.delete_at(@guess.index(guess) || guess.length)
        check_key.delete_at(check_key.index(key) || check_key.length)
        @feedback.push('color_peg')
      end
    end
    return check_key
  end

  def color_match?(check_key, guess)
    @guess.each do |guess|
      if check_key.include?(guess)
        check_key.delete_at(check_key.index(guess) || check_key.length)
        @feedback.push('white_peg')
      end
    end
  end


def get_key()
  @key = Array.new(4) { rand(1...4) }
end

def get_guess()
  puts "you are on turn: " +"#{@turn}"
  while true
    puts 'Please make your selection (four numbers between 1 and 4): '
    guess = gets.chars.each_slice(1).map(&:join)
    guess.map!(&:to_i)
    guess = guess[0..-2]
    if validate_guess(guess) == true
      @guess = guess
      break
    else
      puts "---invalid selection----"
      redo
    end
  end
end

  def validate_guess(guess)
    if guess.length == 4 && (guess.each { |x| x > 1 || x < 4 })
      true
    else
      false
    end
  end


  def play_round(guess, key)
    color_match?(color_pos_match?(key, guess), guess)
  end

  def play_game()
    get_key()
    get_guess()
    while @guess != @key && @turn < 12
        play_round(@guess, @key)
        puts "#{@feedback}" 
        @feedback = []
        @turn +=1
        get_guess
      end
    if @turn >= 12
      puts "out of turns... num nuts"
    else
      puts "you win Mastermind!"
    end 
  end
  
end  


game = Mastermind.new()
game.play_game()


