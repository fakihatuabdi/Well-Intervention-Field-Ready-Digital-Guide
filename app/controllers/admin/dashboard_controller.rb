module Admin
  class DashboardController < BaseController
    def index
      @counts = {
        articles: Article.count,
        published: Article.published.count,
        users: User.count,
        pending: User.pending.count
      }
      @recent_events = AuditEvent.recent.limit(10)
    end
  end
end
