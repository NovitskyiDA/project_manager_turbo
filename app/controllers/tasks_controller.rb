class TasksController < ApplicationController
  before_action :set_task, only: [ :update, :destroy ]

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(task_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to project_path(@project) }
    end
  end

  def update
    @task.update(task_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to project_path(@task.project) }
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to project_path(@task.project) }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :parent_id)
  end
end
