module Admin
  # Announcements shown on the home page ("Updates & Notices").
  class UpdatesController < BaseController
    before_action :set_update, only: %i[edit update destroy]

    def index
      @updates = Update.order(published_at: :desc).page(params[:page]).per(50)
    end

    def new
      @update = Update.new(published_at: Time.current, category: "announcement")
    end

    def create
      @update = Update.new(update_params)
      if @update.save
        audit!("update.create", target: @update)
        redirect_to admin_updates_path, notice: "Notice created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @update.update(update_params)
        audit!("update.update", target: @update, details: change_summary(@update))
        redirect_to admin_updates_path, notice: "Notice saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @update.destroy!
      audit!("update.destroy", target: @update)
      redirect_to admin_updates_path, notice: "Notice deleted.", status: :see_other
    end

    private

    def set_update
      @update = Update.find(params[:id])
    end

    def update_params
      params.require(:update).permit(:title, :content, :category, :published_at)
    end
  end
end
