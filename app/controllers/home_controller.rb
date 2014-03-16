class HomeController < ApplicationController
  def index
  
  @commits = {"2013" => {
  	janvier: [
  		{date: "1 Janvir 2013", user: "malachheb", comment: "change readme file"},
  		{date: "10 Janvir 2013", user: "malachheb", comment: "change test file"},
  		{date: "20 Janvir 2013", user: "malachheb", comment: "Fix Bug"},
  		{date: "26 Janvir 2013", user: "jonathan", comment: "change readme file"}
  	],

  	fevrier:[
  		{date: "1 Janvir 2013", user: "malachheb", comment: "change readme file"},
  		{date: "10 Janvir 2013", user: "malachheb", comment: "change test file"}
  	],

  	},
  	"2014" => {
  		janvier: [
  			{date: "1 Janvir 2013", user: "malachheb", comment: "change readme file"},
  			{date: "10 Janvir 2013", user: "malachheb", comment: "change test file"},
  			{date: "20 Janvir 2013", user: "malachheb", comment: "Fix Bug"},
  			{date: "26 Janvir 2013", user: "jonathan", comment: "change readme file"}
  		],

  		fevrier:[
  			{date: "1 Janvir 2013", user: "malachheb", comment: "change readme file"},
  			{date: "10 Janvir 2013", user: "malachheb", comment: "change test file"}
  		]

  	} 

  }

  end
  		
end
