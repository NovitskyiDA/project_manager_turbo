class ProjectsController < ApplicationController
  before_action :set_project, only: [ :show, :destroy ]

  def index
    @projects = Project.ordered_by_name.includes(:tasks).page(params[:page]).per(10)
  end

  def show
    @tasks = @project.tasks
        .active
        .root_tasks
        .includes(:subtasks)
        .order(created_at: :asc)
        .page(params[:page])
        .per(10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to projects_path, notice: "Project was successfully deleted." }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
