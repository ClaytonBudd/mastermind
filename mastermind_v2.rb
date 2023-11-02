class Mastermind
  def initialize
    @key = []
    @guess = []
    @feedback = []
    @turn = 1
    @computer_guess = []
    @computer_used_guesses = []
  end

  def color_pos_match?(_key, guess) 
    check_key = @key.clone
    check_guess =@guess.clone
    check_guess.zip(check_key).each do |guess, key|
      if guess == key
        check_guess.delete_at(check_guess.index(guess) || guess.length)
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


def get_random_computer_selection()
  return Array.new(4) { rand(1...4) }
end


def get_human_key()
  @key = get_selection()
end

def get_human_selection()
  puts "you are on turn: " +"#{@turn}"
  while true
    puts 'Please make your selection (four numbers between 1 and 4): '
    guess = gets.chars.each_slice(1).map(&:join)
    guess.map!(&:to_i)
    guess = guess[0..-2]
    if validate_guess(guess) == true
      return guess
    else
      puts "---invalid selection----"
      redo
    end
  end
end

def get_computer_guess()
  guess = []
  random_guess = @guess.shuffle.clone()
  colored_pegs = @feedback.count("color_peg")
  colored_pegs.times do
    guess.push(random_guess[0])
    random_guess.shift
  end
  white_pegs = @feedback.count("white_peg")
  white_pegs.times do
    guess.push(random_guess[0])
    random_guess.shift
  end
  while guess.length != 4 
    guess.push(rand(1..4))
  end
  if @computer_used_guesses.include?(@guess)
    @guess = get_computer_guess()
  end
  puts "#{guess}"
  @computer_used_guesses.push(@guess)
  return guess
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

  def game_type()
    puts "Please select your game type" + "\n" + "1: Computer keymaker, Human codebreaker" + "\n" + "2: Human keymaker, computer codebreaker"
    game_type = 2 #gets.chomp.to_i 
    while game_type != 1 && game_type != 2
      game_type = gets.chomp.to_i
      puts game_type
    end
    if game_type == 1
      play_game_human_guess()
    else
      play_game_computer_guess()
    end
  end


  #similar to play_game_human_guess but with 
  def play_game_computer_guess
    @key = [1,2,3,4]#get_human_selection()
    @guess = get_random_computer_selection
    while @guess != @key && @turn < 12
      play_round(@guess, @key)
      puts "#{@feedback}"
      @turn += 1
      @guess = get_computer_guess()
      @feedback = []
    end
    if @turn >= 12
      puts "out of turns .. numnuts"
    else
      puts "you win Codebreaker"
    end
    if @computer_used_guesses.uniq
      puts "unique"
    end
  end

  def play_game_human_guess()
    @key = get_random_computer_selection()
    @guess = get_human_selection()
    while @guess != @key && @turn < 12
        play_round(@guess, @key)
        puts "#{@feedback}" 
        @feedback = []
        @turn +=1
        @guess = get_human_selection()
      end
    if @turn >= 12
      puts "#{@computer_used_guesses}"
      puts "out of turns... num nuts"
    else
      puts "you win Codebreaker!"
    end 
  end
  
end  


game = Mastermind.new()
game.game_type()


