class GithubService

  def self.contributors
    response = HTTParty.get 'https://api.github.com/repos/jusrez/little-esty-shop/contributors'

    array = JSON.parse(response.body, symbolize_names: true).map{ |contributor| "#{contributor[:login]} - #{contributor[:contributions]} commits" }
  end

end