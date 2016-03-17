class GirlsStemCamps::CLI
	def call
		puts "Welcome to the 2016 listing of summer STEM camps for high school girls"
		list_camps
		menu
		goodbye
	end

	def list_camps
		#get the camps and list by number
		@camps = GirlsStemCamps::Camp.get_camps
		@camps.each_with_index do |camp, i|
			puts "#{i+1}. #{camp.name} at #{camp.location}"
		end
	end

	def menu
		input = nil
		while input != "exit"
			puts "Enter the number of the camp that you would like more information about"
			input = gets.strip.downcase
			if input.to_i.between?(1, @camps.size)
				puts @camps[input.to_i - 1].name
				puts " "
				puts "Camp Price:"
				puts @camps[input.to_i - 1].price 
				puts " "
				puts "Camp Dates:"
				puts @camps[input.to_i - 1].date 
				puts " "
				puts "Camp Description:" 
				puts @camps[input.to_i - 1].description
				puts " "
				puts "Camp Website:"
				puts @camps[input.to_i - 1].url
				puts " "
				puts "Would you like to open the website?"
					input = gets.strip.downcase
					if input == "yes"
						`open "#{@camps[input.to_i-1].url}"`
					end
			elsif input == "list"
				list_camps
			else puts "Please enter exit, list, or a number"
			end
		end
	end

	def goodbye
		puts "Goodbye!"
	end






end