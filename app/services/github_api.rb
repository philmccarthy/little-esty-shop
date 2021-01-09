class GithubApi
  def repo
    @conn = Faraday.new(url: "https://api.github.com")
  end

  def call(arg)
    repo
    response = @conn.get("/repos/elyhess/little-esty-shop#{arg}")
    github = JSON.parse(response.body, :symbolize_names => true)
  end
end
