class Repo

  def service
    GithubApi.new
  end

  def pr_count
    service.call("/pulls?state=closed").count
  end

  def names
    service.call("/commits").map do |commit|
      commit[:author][:login]
    end.uniq
  end

  def commits_count
    hash = {}
    names.each do |name|
      hash[name] = service.call("/commits?author=#{name}&per_page=100").size
    end
    hash
  end
end
