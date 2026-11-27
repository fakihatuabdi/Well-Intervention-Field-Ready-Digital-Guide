module Admin
  # "Case Studies & Lessons Learned" shown on the home page.
  class CaseStudiesController < BaseController
    before_action :set_case_study, only: %i[edit update destroy]

    def index
      @case_studies = CaseStudy.order(created_at: :desc).page(params[:page]).per(50)
    end

    def new
      @case_study = CaseStudy.new(published: false)
    end

    def create
      @case_study = CaseStudy.new(case_study_params)
      if @case_study.save
        audit!("case_study.create", target: @case_study)
        redirect_to admin_case_studies_path, notice: "Case study created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @case_study.update(case_study_params)
        audit!("case_study.update", target: @case_study, details: change_summary(@case_study))
        redirect_to admin_case_studies_path, notice: "Case study saved."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @case_study.destroy!
      audit!("case_study.destroy", target: @case_study)
      redirect_to admin_case_studies_path, notice: "Case study deleted.", status: :see_other
    end

    private

    def set_case_study
      @case_study = CaseStudy.find(params[:id])
    end

    def case_study_params
      params.require(:case_study).permit(:title, :description, :content, :published)
    end
  end
end
