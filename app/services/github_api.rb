class GithubApi
  def repo
    @conn = Faraday.new(url: "https://api.github.com")
  end

  def call(arg)
    repo
    response = @conn.get("/repos/elyhess/little-esty-shop#{arg}")
    github = JSON.parse(response.body, :symbolize_names => true)
  end

  def pulls
    call("/pulls?state=closed")

  end

  def commits
    call("/commits")
  end

  def commits_by_author(name)
    call("/commits?author=#{name}&per_page=100")
  end

end
