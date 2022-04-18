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
    @project.project_investigators.build
  end

  # GET /projects/1/edit
  def edit
    @project.project_investigators.build
    @main_investigator_email = nil
    @investigators = []

    if @project.id
      @main_investigator_email = ProjectInvestigator.where(project_id: @project.id, role: 0).first.investigator.email

      (ProjectInvestigator.all).each do |associated|
        if associated.project.id == @project.id && associated.role != "main"
          @investigators.push(associated.investigator)
        end
      end
    end
  end

  # POST /projects or /projects.json
  def create
    
    @project = Project.new(code: project_params[:code], name: project_params[:name])
    
    respond_to do |format|
      if @project.save
        (project_params[:project_investigators_attributes].values).each do |associated|
          if associated["_destroy"] != "1"
            ProjectInvestigator.create(project: @project, investigator: Investigator.find(associated[:investigator_id]))
            
          end
        end
    
        if params[:main_investigator_email]
          ProjectInvestigator.create(project: @project, investigator: Investigator.where(email: params[:main_investigator_email]).first, role: 0)
        end
        
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
      if @project.update(code: project_params[:code], name: project_params[:name])
        if project_params[:project_investigators_attributes]
          (project_params[:project_investigators_attributes].values).each do |associated|
            if associated["_destroy"] != "1"
              @investigator_associated = ProjectInvestigator.where(project: @project, investigator: Investigator.find(associated[:investigator_id]))
              if @investigator_associated.length == 0
                ProjectInvestigator.create(project: @project, investigator: Investigator.find(associated[:investigator_id]))
              end
            end
          end

          (project_params[:project_investigators_attributes].values).each do |associated|
            if associated["_destroy"] == "1"
              @investigator_associated = ProjectInvestigator.where(project: @project, investigator: Investigator.find(associated[:investigator_id])).first
              if @investigator_associated
                @investigator_associated.destroy
              end
            end
          end
          

        end
    
        if params[:main_investigator_email]
          @main_investigator = ProjectInvestigator.where(project: @project, investigator: Investigator.where(email: params[:main_investigator_email]).first, role: 0).first
          if !@main_investigator
            @past_main_investigator = ProjectInvestigator.where(project: @project, role: 0).first
            @past_main_investigator.destroy

            ProjectInvestigator.create(project: @project, investigator: Investigator.where(email: params[:main_investigator_email]).first, role: 0)
          end
        end

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


  def get_project_investigators
    respond_to do |format|
      format.json { render json: { data: Investigator.all } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:code, :name, project_investigators_attributes: [:investigator_id, :project_id, :_destroy])
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