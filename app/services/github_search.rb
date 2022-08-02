require_relative 'github_service'

class GithubSearch

  def repo_name
    service.repo[:name]
  end

  def contributors
    service.contributors.map do |contributor|
      "#{contributor[:login]} - #{contributor[:contributions]} commits"
    end
  end

  def merged_pull_requests
    service.merged_pull_requests[:total_count]
  end

  def service
    GithubService.new
  end

end