

require 'yaml'

class Hangman_Game

    def initialize
        @secret_word=get_secret
        @turns_left=7
        @disp=""
        @used_letters=[]
        create_disp
        @empty_spots=@secret_word.length
        print_disp
        start_game

    end

    def start_game
        game_done=false

        while !game_done
            player_choice=get_player_choice
            if player_choice=="save"
                game_done=true
                puts "FOUND SAVE!!!"
            else
                correct_spots=check_guess(player_choice)
                if correct_spots.length<1
                    @turns_left-=1
                    @used_letters.push(player_choice)
                    puts "WRONG"
                    puts @turns_left.to_s
                else
                    update_board(player_choice,correct_spots)
                    @empty_spots-=correct_spots.length
                end
                if @turns_left==0
                    game_done=true
                    declare_loss
                end
                if @empty_spots==0
                    game_done=true
                    declare_win
                end
            
            end
            print_disp

        end
    end

    def get_secret
        file=File.open("5desk.txt")

        words=file.read.split

        valid_words=[]

        words.each do |word|
            if word.length<=12 && word.length>=5
                valid_words.push(word)
            end
        end

        right_answer=valid_words.sample
        return right_answer.downcase
    end
    
    def create_disp
        @disp="|"
        @secret_word.length.times do
            @disp=@disp+" |"
        end
        
    end

    def check_guess(guess)
        locs=[]
        @secret_word.chars.each_with_index do |n,index|
            if n==guess
                locs.push(index)
            end
        end
        return locs
    end

    def get_player_choice
        valid_guess=false
        
        while(!valid_guess)
            puts "Take a guess: "
            guess=gets.chomp
            
            if guess.match(/^[A-Za-z]$/) && !(@used_letters.include? guess)
                valid_guess=true
            end
            if guess.match(/save/)
                save_game(self)
                
                break
            end
        end
        
            return guess.downcase
       
         
    end

    def update_board(guess,correct_spots)
        correct_spots.each do |n|
            @disp[2*n+1]=guess
        end
    end

    def print_disp
        
        puts @disp+" Turns Left: #{@turns_left} Used Letters: #{@used_letters}"
        puts @secret_word
    end 
    
    def declare_loss
        puts "You LOSE YOU SUCK YOU SUCK YOU LOSE"
    end
    
    def declare_win
        puts "GOOD JOB YOU FUCKING NERD!!! YOU BEAT A COMPUTer"
    end

end

def save_game(game)
	yaml = YAML::dump(game)
    game_file = File.open("save.txt","w")
  game_file.write(yaml)
  #puts yaml
end

my_game=Hangman_Game.new
