module RepositoriesHelper
  def chart_data(commits, user)
    months_names = (2..12).map{|m| Date::ABBR_MONTHNAMES[m]}
    labels = []
    data = []
    user_data = []
    commits.asc(:date).group_by{|c| c.date.year}.each do |key, vals|
      labels = (labels << key) + months_names
      (1..12).each do |m|
        data << commits.where(:date.gte => Date.new(key.to_i, m), :date.lt => Date.new(key.to_i, m).next_month ).count
        user_data << commits.where('commiter.login' => user, :date.gte => Date.new(key.to_i, m), :date.lt => Date.new(key.to_i, m).next_month ).count
      end
    end
    {labels: labels, data: data, user_data: user_data}
  end

  def next_page(page, total)
    nb_pages = (total/10.0).ceil
    (page+1) > nb_pages ? nb_pages : (page + 1) 
  end

  def prev_page(page, total)
    nb_pages = (total/10.0).ceil
    (page-1) <= 0 ? 1 : (page - 1) 
  end

  def last_page(total)
    (total/10.0).ceil
  end

end
