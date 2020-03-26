class CLI

    def run
        greeting
        # user_login
        prompt_user
        choose_from_option_tree
    end
    
    def greeting
        puts '-' * 100
        puts ''
        puts "Welcome to the Magic Manager"
        puts ''
        puts '-' * 100
        puts ''
        puts 'Here you can keep your Magic the Gathering collection organized.'
        puts ''
        puts 'Please enter a USERNAME and PASSWORD to begin.'
    end

    def user_login
        puts "username:"
        username = get_input
        puts "password:"
        password = get_input
        @current_user = User.find_or_create_by(username: username, password: password)
        ####to authenticate
                #find or creat by username
                #if password == nil
                    #user.password = password
                #elsif password == user.password
                    #sign-in successful
                #else 
                    #password and username do not match.. please try again
        ####to authenticate
    end

    def get_input
        gets.chomp
    end

    def prompt_user
       puts ''
       puts "Enter a number to select an option below:"
       puts "   1: Search for New Cards"
       puts "   2: View Collection" #user_card
       puts "   3: Manage Decks"
    end

    def choose_from_option_tree
        input = get_input.to_i
        case input
        when 1
            search_for_new_cards
        when 2
            #view collection
        when 3
            #manage decks
        else
            "Invalid input. Please enter a valid command:"
            option_tree
        end
    end

#-----------------------------------------------SEARCH FOR NEW CARDS -----------------------------------------------------------------

    def search_for_new_cards
        prompt_search_params
        num = get_input.to_i
        case num
        when 1
            puts "Please type a card name:"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
        when 2
            puts "Please type a card color:"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?colors=#{search}"
        when 3
            puts "Please type a card type:"
            search = get_input
            url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
        else
            puts "Invalid command."
            search_for_new_cards
        end
        
        results = AccessAPI.new.seed_db_with_cards(url)
        binding.pry
        results.each {|card| card.display}
    end

    def prompt_search_params
        puts ''
        puts "Enter a number based on how you would like to search:"
        puts "     1: Search by name"
        puts "     2: Search by color"
        puts "     3: Search by type"
    end

    # def build_url
    #     prompt_search_params
    #     num = get_input.to_i
    #     case num
    #     when 1
    #         puts "Please type a card name:"
    #         search = get_input
    #         url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
    #     when 2
    #         puts "Please type a card color:"
    #         search = get_input
    #         url = "https://api.magicthegathering.io/v1/cards?colors=#{search}"
    #     when 3
    #         puts "Please type a card type:"
    #         search = get_input
    #         url = "https://api.magicthegathering.io/v1/cards?name=#{search}"
    #     else
    #         puts "Invalid command."
    #         build_url
    #     end
    #     url
    # end

    # def setup_url_by_params(num)
    #     url = nil
    #     case num
    #     when 1
    #         url = "https://api.magicthegathering.io/v1/cards?name="
    #     when 2
    #         url = "https://api.magicthegathering.io/v1/cards?colors="
    #     when 3
    #         url = "https://api.magicthegathering.io/v1/cards?types="
    #     else
    #         "Please enter valid input"
    #     end
    #     url
    # end

    # def prompt_search_terms
    #     puts "Please enter what you would like to search for:"
    # end

    # def setup_full_url(params, search)
    #     url = "#{params}" + "#{search}"
    # end

#----------------------------------------------SEARCH FOR NEW CARDS-----------------------------------------------------------------




end




# def run(songs)
#     while true do
#       puts "Please enter a command:"
#       response = gets.chomp
#       case response
#       when "exit"
#         exit_jukebox
#         break
#       when "play"
#         play(songs)
#       when "help"
#         help
#       when "list"
#         list(songs)
#       else
#         puts "Invalid entry"
#       end
#     end
#   end
  
#   def play(songs)
#     puts "Please enter a song name or number:"
#     response = gets.chomp
#     if response.to_i >= 1 && response.to_i <= songs.length
#       puts "Playing #{songs[response.to_i-1]}"
#     elsif songs.include?(response)
#       puts "Playing #{songs.find{|song| song == response}}"
#     else
#       puts "Invalid input, please try again"
#     end
#   end
  
#   def exit_jukebox
#     puts "Goodbye"
#   end
  
#   def help
#   puts  "I accept the following commands:"
#   puts  "- help : displays this help message"
#   puts  "- list : displays a list of songs you can play"
#   puts  "- play : lets you choose a song to play"
#   puts  "- exit : exits this program"
#   end
  
#   def list(songs)
#   songs.each_with_index {|song, index|
#     puts "#{index+1}. #{song}"
#   }
#   end