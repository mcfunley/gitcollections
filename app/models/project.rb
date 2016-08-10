class Project < ActiveRecord::Base
  belongs_to :collection
  has_many :issues, dependent: :destroy

  validates :url, presence: true

  def update_project
    gh_project = GithubProject.new(self.url)
    self.update(name: gh_project.name, description: gh_project.description)
  end

  def update_issues
    Issue.where(project_id: self.id).destroy_all

    gh_project = GithubProject.new(self.url)
    unless gh_project.issues.blank?
      gh_project.issues.map do |issue|
        Issue.create(title: issue.title, project: self, url: issue.html_url, labels: labels(issue.labels))
      end
    end
  end
  handle_asynchronously :update_issues

  private

  def labels(labels)
    labels.map { |label| label[:name] }
  end
end
