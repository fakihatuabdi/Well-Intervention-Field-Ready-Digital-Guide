module Admin
  class AuditEventsController < BaseController
    def index
      scope = AuditEvent.recent
      scope = scope.where("action LIKE ?", "#{AuditEvent.sanitize_sql_like(params[:action_prefix])}%") if params[:action_prefix].present?
      @events = scope.page(params[:page]).per(100)
    end
  end
end
