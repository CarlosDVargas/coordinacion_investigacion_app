class CertificatesController < ApplicationController
  before_action :set_certificate, only: %i[ show edit update destroy ]

  # GET /certificates or /certificates.json
  def index
    @certificates = Certificate.all
  end

  # GET /certificates/1 or /certificates/1.json
  def show
  end

  # GET /certificates/new
  def new
    @certificate = Certificate.new
  end

  # GET /certificates/1/edit
  def edit
  end

  # POST /certificates or /certificates.json
  def create
    @certificate = Certificate.new(certificate_params)

    respond_to do |format|
      if @certificate.save
        format.html { redirect_to certificate_url(@certificate), notice: "Certificate was successfully created." }
        format.json { render :show, status: :created, location: @certificate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certificates/1 or /certificates/1.json
  def update
    respond_to do |format|
      if @certificate.update(certificate_params)
        format.html { redirect_to certificate_url(@certificate), notice: "Certificate was successfully updated." }
        format.json { render :show, status: :ok, location: @certificate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certificates/1 or /certificates/1.json
  def destroy
    @certificate.destroy

    respond_to do |format|
      format.html { redirect_to certificates_url, notice: "Certificate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certificate
      @certificate = Certificate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def certificate_params
      params.require(:certificate).permit(:certificateNumber, :date)
    end
end
