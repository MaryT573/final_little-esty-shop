class GithubService

  def repo
    get_url('https://api.github.com/repos/jusrez/little-esty-shop')
  end

  def contributors
    get_url('https://api.github.com/repos/jusrez/little-esty-shop/contributors')
  end

  def merged_pull_requests
    get_url('https://api.github.com/search/issues?q=repo:jusrez/little-esty-shop%20type:pr%20is:merged')
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end