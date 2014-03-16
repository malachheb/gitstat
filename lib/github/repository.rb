class Github::Repository
	include HTTParty

	base_uri 'https://api.github.com'

	def initialize
    	@auth = { :username => 'malachheb', :password => 'cout123' }
  	end

	def user(id)
    	self.class.get("/users/#{id}", {:basic_auth =>@auth,  :headers => {"User-Agent" => "malachheb"} })
  	end

  	def repository(name)
  		self.class.get("/repos/malachheb/#{name}/commits", {:basic_auth =>@auth, :headers => {"User-Agent" => "malachheb"} })
  	end

end