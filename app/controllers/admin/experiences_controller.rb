module Admin
  class ExperiencesController < BaseController
    before_action :set_experience, only: %i[show edit update destroy remove_screenshot]

    def index = @experiences = Experience.ordered
    def show; end
    def new = @experience = Experience.new
    def edit; end
    def create
      @experience = Experience.new(experience_params)
      @experience.save ? redirect_to(admin_experience_path(@experience), notice: "Experience created.") : render(:new, status: :unprocessable_entity)
    end
    def update
      @experience.update(experience_params) ? redirect_to(admin_experience_path(@experience), notice: "Experience updated.") : render(:edit, status: :unprocessable_entity)
    end
    def destroy
      @experience.destroy!
      redirect_to admin_experiences_path, notice: "Experience deleted."
    end
    def remove_screenshot
      @experience.screenshots.find(params[:attachment_id]).purge
      redirect_to edit_admin_experience_path(@experience), notice: "Screenshot removed."
    end
    private
    def set_experience = @experience = Experience.find(params[:id])
    def experience_params = params.require(:experience).permit(:title, :company, :subtitle, :short_description, :description, :technologies, :start_date, :end_date, :current, :featured, :position, screenshots: [])
  end
end
