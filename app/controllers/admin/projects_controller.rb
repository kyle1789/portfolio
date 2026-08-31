module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: %i[show edit update destroy remove_screenshot]

    def index = @projects = Project.ordered
    def show; end
    def new = @project = Project.new
    def edit; end
    def create
      @project = Project.new(project_params)
      @project.save ? redirect_to(admin_project_path(@project), notice: "Project created.") : render(:new, status: :unprocessable_entity)
    end
    def update
      @project.update(project_params) ? redirect_to(admin_project_path(@project), notice: "Project updated.") : render(:edit, status: :unprocessable_entity)
    end
    def destroy
      @project.destroy!
      redirect_to admin_projects_path, notice: "Project deleted."
    end
    def remove_screenshot
      @project.screenshots.find(params[:attachment_id]).purge
      redirect_to edit_admin_project_path(@project), notice: "Screenshot removed."
    end
    private
    def set_project = @project = Project.find(params[:id])
    def project_params = params.require(:project).permit(:name, :short_description, :description, :technologies, :github_url, :live_url, :featured, :position, screenshots: [])
  end
end
