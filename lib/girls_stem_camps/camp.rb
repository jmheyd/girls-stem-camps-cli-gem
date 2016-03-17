class GirlsStemCamps::Camp
	attr_accessor :name, :date, :price, :location, :description, :url

	def self.get_camps    
		#scrape and return camps
		camps = []
		camps << self.scrape_stmarys
		camps << self.scrape_nebraska
		camps << self.scrape_minnesota
		camps << self.scrape_power
		camps << self.scrape_curie
		camps << self.scrape_michigan_engineering
		camps << self.scrape_michigan_computersci
		#scraping from each website?? 
		#need to require nokogirl and open-uri
		camps
	end

	def self.scrape_stmarys
		doc = Nokogiri::HTML(open("http://events.saintmarys.edu/s/1611/index.aspx?sid=1611&gid=6&pgid=831"))
		camp = self.new
		#camp.name = doc.search("div.snippetrow h1").text
		#binding.pry
		camp.name = doc.search("p strong")[2].text
		camp.date = doc.search("h2").last.text.gsub("Forensic Science Camp", "")
		camp.price = doc.search("p strong")[3].text
		camp.location = doc.search("div#ContentFooter p").text.gsub("\r\n", " ").gsub("46556 1-574-284-4000", "")
		#camp.location = doc.search("div.snippetrow strong")[8].text.gsub("Saint Mary's Summer Camps", "").strip
		camp.description = doc.search("div.split50left p")[5].text
		camp.url = "http://events.saintmarys.edu/s/1611/index.aspx?sid=1611&gid=6&pgid=831"
		camp
	end

	def self.scrape_nebraska
		doc = Nokogiri::HTML(open("http://www.math.unl.edu/programs/agam"))
		camp = self.new	
		camp.name = doc.search("span.wdn-promo-text").text
		camp.date = doc.search("div.wdn-col-full p:nth-child(7)").text.gsub("Summer 2016 Information: We will hold two one-week camps on ", "").gsub(". Campers must provide their own transportation to and from Lincoln, Nebraska, as well as transportation to and from the Lincoln Airport (LNK) to the UNL campus; however, our camp coordinators will assist with arranging transportation to and from the airport to the dorm.A limited number of additional scholarships for registration or travel support are available. Participants who need such a scholarship will be asked to explain their financial need situation in the online AGAM application.", "")
		camp.price = doc.search("div.wdn-col-full p:nth-child(4)").text.gsub("For students who do not live in Nebraska, “out-state,” AGAM has a voluntary two-tiered pricing system, allowing out-state families to choose the price that works best for them. Naming your price requires no paperwork and in no way influences the experience your child will receive at camp. There are two tiers: ","").gsub(". The true per-student cost for the camp, including the cost of providing instruction, housing, meals, and social activities, is a bit more than $1,000. Due to the generosity of our sponsors, this cost is cut in half for all campers. Price A is the cost of the camp that is not already covered by grant support. Price B is a partially subsidized rate for families that could use a little help. On the online application, your family will select one of these two pricing tiers. Simply choose the rate that is appropriate for your family.","")
		camp.location = doc.search("span#wdn_institution_title").text
		camp.description = doc.search("div.wdn-col-full p:nth-child(2)").text
		camp.url = "http://www.math.unl.edu/programs/agam"
		camp
	end

	def self.scrape_minnesota
		doc = Nokogiri::HTML(open("https://cse.umn.edu/r/discover-stem/"))
		camp = self.new
		camp.name = doc.search("h1.single-title").text
		camp.date = doc.search("strong")[1].text
		camp.price =  doc.search("p.p1")[2].text.gsub("Thanks to the generosity of 3M and an anonymous private donor, we are able to offer Discover STEM to admitted students for only a ", "").gsub(" enrollment fee, and full scholarships are available upon request to admitted students demonstrating financial need. The enrollment fee will only be collected from students upon admittance into Discover STEM (see “Admissions timeline” below for details).", "")
		camp.location = doc.search("strong")[2].text.gsub("9 a.m.–4 p.m.\n", "")
		camp.description = doc.search("p.p1")[0].text
		camp.url = "https://cse.umn.edu/r/discover-stem/"
		camp
	end

		def self.scrape_power
		doc = Nokogiri::HTML(open("http://www.engr.iupui.edu/infofor/community/summer-camps/power-camp.php"))
		#binding.pry
		camp = self.new
		camp.name = doc.search("p strong")[3].text.strip.gsub(" - July 17 - 23, 2016", "").gsub("2016 ", "")
		camp.date = doc.search("p strong")[3].text.strip.gsub("2016 POWER SUMMER CAMP - ", "")
		camp.price = doc.search("p:nth-child(8)").text.gsub("Cost:  ", "")
		camp.location = doc.search("span.show-on-desktop").text
		camp.description = doc.search("div p")[5].text
		#doc.search("p:nth-child(6)").text
		camp.url = "http://www.engr.iupui.edu/infofor/community/summer-camps/power-camp.php"
		camp
	end

	def self.scrape_curie
		doc = Nokogiri::HTML(open("http://cornellcurie.weebly.com/"))
		#binding.pry
		camp = self.new
		camp.name = doc.search("div.paragraph strong")[0].text
		camp.date = doc.search("h2.wsite-content-title")[0].text
		camp.price = doc.search("td.wsite-multicol-col div.paragraph span")[18].text.gsub("*","")
		camp.location = doc.search("div.paragraph font strong")[1].text.gsub("The CURIE Academy  |  Diversity Programs in Engineering  146 Olin Hall, ", "").gsub(" |  Ithaca, NY 14853", "") 
		doc2 = Nokogiri::HTML(open("http://cornellcurie.weebly.com/schedule.html"))
		#binding.pry
		camp.description =  doc2.search("div.paragraph span font").text
		camp.url = "http://cornellcurie.weebly.com/"
		camp
	end

	def self.scrape_michigan_engineering
		doc = Nokogiri::HTML(open("http://www.syp.mtu.edu/courses-scholarship.php#Women_in_Engineering"))
		#binding.pry
		camp = self.new
		camp.name = doc.search("span strong a")[1].text
		doc2 = Nokogiri::HTML(open("http://www.syp.mtu.edu/tuition-dates-important.php"))
		#binding.pry
		camp.date = doc2.search("li span")[7].text.gsub("\r\n\t\t\t\t\t\t\t\t\t\t\tWIE: ", "")
		camp.price = doc.search("table p span")[14].text.gsub("\n\t\t\t\t\t\t\t\t\t\tThis program is a highly competitive \n\t\t\t\t\t\t\t\t\t\tscholarship program that provides a \n\t\t\t\t\t\t\t\t\t\tchance for women to investigate careers \n\t\t\t\t\t\t\t\t\t\tin engineering and science. You will \n\t\t\t\t\t\t\t\t\t\tparticipate in engineering sessions, \n\t\t\t\t\t\t\t\t\t\tgroup projects, and special topic \n\t\t\t\t\t\t\t\t\t\tpresentations with a diverse group of \n\t\t\t\t\t\t\t\t\t\tpeers from all over the country and \n\t\t\t\t\t\t\t\t\t\taround the world.You can request \n\t\t\t\t\t\t\t\t\t\tto talk with university faculty from \n\t\t\t\t\t\t\t\t\t\tareas that you're interested in, as well \n\t\t\t\t\t\t\t\t\t\tas staff from admissions and financial \n\t\t\t\t\t\t\t\t\t\taid.WIE requires a\n\t\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\tseparate application. Accepted \n\t\t\t\t\t\t\t\t\t\tstudents receive a scholarship valued at \n\t\t\t\t\t\t\t\t\t\tover $1,000 that covers tuition, room \n\t\t\t\t\t\t\t\t\t\tand board, and supplies. A nonrefundable \n\t\t\t\t\t\t\t\t\t\t","").gsub(" registration fee is due within ten \n\t\t\t\t\t\t\t\t\t\tdays of being accepted into the program. \n\t\t\t\t\t\t\t\t\t\tStudents are responsible for their own \n\t\t\t\t\t\t\t\t\t\ttravel expenses and spending money for \n\t\t\t\t\t\t\t\t\t\tthe week. WIE scholarship funding is \n\t\t\t\t\t\t\t\t\t\tprovided by corporations, organizations, \n\t\t\t\t\t\t\t\t\t\tand Michigan Tech.","")
		camp.location = doc.search("table p span strong")[17].text.gsub(" Summer Youth Programs", "")
		camp.description = doc.search("table p span")[11].text.gsub("\n\t\t\t\t\t\t\t\t\t\t", "")
		camp.url = "http://www.syp.mtu.edu/courses-scholarship.php#Women_in_Engineering"
		camp
	end

	def self.scrape_michigan_computersci
		doc = Nokogiri::HTML(open("http://www.syp.mtu.edu/courses-scholarship.php#Women_in_Computer_Science"))
		#binding.pry
		camp = self.new
		camp.name = doc.search("span a")[4].text.gsub("\n\t\t\t\t\t\t\t\t\t\t\t", "")
		camp.date = doc.search("tr td p span")[32].text.gsub("\n\t\t\t\t\t\t\t\t\t\tDates for Women in Computer Science 2016 \n\t\t\t\t\t\t\t\t\t\tare ", "")
		camp.price = doc.search("tr td p span")[30].text.gsub("\n\t\t\t\t\t\t\t\t\t\t", "").gsub("Cost: ", "")
		camp.location = doc.search("table p span strong")[17].text.gsub(" Summer Youth Programs", "")
		camp.description = doc.search("tr td p span")[29].text.gsub("\n\t\t\t\t\t\t\t\t\t\t", "")
		camp.url = "http://www.syp.mtu.edu/courses-scholarship.php#Women_in_Computer_Science"
		camp

end
end
