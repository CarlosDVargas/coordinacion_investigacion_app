class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @investigators = []
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Se ha eliminado el proyecto." }
      format.json { head :no_content }
    end
  end

  def register_project_investigators
    @investigators = []
    if !params[:delete]
      if params[:investigator]
        if params[:investigators].size > 0
          (params[:investigators]).each do |email_added|
            @investigators += Investigator.where(email: email_added)
          end
        end

        if !Investigator.where(email: params[:investigator][0]).empty? && verify_investigator_added(params[:investigator][0], @investigators)
          @investigators += Investigator.where(email: params[:investigator][0])
        end
      end

    else
      if params[:investigator]
        if params[:investigators].size > 0
          (params[:investigators]).each do |email_added|
            if email_added != params[:investigator][0]
              @investigators += Investigator.where(email: email_added)
            end
          end
        end

      end
    end

    render partial: "projects/associated_investigator_list", locals: { investigators: @investigators }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:code, :name)
    end

    def verify_investigator_added(email_received, investigators)
      (investigators).each do |investigator_added|
        if investigator_added.email == email_received
          return false
        end
      end
      return true
    end
end