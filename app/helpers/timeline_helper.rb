module TimelineHelper

	def timeline_css()
		css = {}
		commits_year = @repo.commits.asc(:date).map{|c| c.date.year}.uniq
		css[:year_count] = commits_year.size
		css[:width] = 1846*commits_year.size
		css[:top_time_nav] = -180 + (@repo.commits.size*45)
		css[:height_time_back] = 50 + (@repo.commits.size*45)
		css[:year_pos] = {}
		commits_year.each_with_index do |v, y|
			css[:year_pos][v]= {}
			css[:year_pos][v][:pos] = 16+(y*150*12)
			css[:year_pos][v][:months] = {}
			months_names.each_with_index do |m,i|
				css[:year_pos][v][:months][m] = (y*12*150)+16+((i+1)*150);
			end
		end
		css
	end

	def commit_css_pos(repo)
		commits_pos = {}
		commits_year = @repo.commits.asc(:date).map{|c| c.date.year}.uniq
        current_month = 0; count_month = 0;
        @repo.commits.asc(:date).each do |commit|
         	commit_pos = 13+(150*12*commits_year.index(commit.date.year))+(150*(commit.date.month.to_i-1))+(5*commit.date.day.to_i)
         	if commit.date.month.to_i == current_month
        		count_month +=1
        	else
        		current_month= commit.date.month.to_i; count_month = 0
        	end
        end
	end

end