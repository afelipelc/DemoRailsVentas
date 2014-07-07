class ClientsController < ApplicationController
  load_and_authorize_resource ##autorizar
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
  end
  
  autocomplete :client, :nombre, :display_value => :nombre, :extra_data => [:direccion, :telefono, :email] do |items|
    respond_to do |format|
     format.json { render :json => @items }
    end
  end

# el autocomplete se tomo de http://rubydoc.info/gems/rails4-autocomplete/1.1.0/frames
# se instalo el rails jquery ui gem
# no se agrego el javascript tag en el layout


   #, :full => true  << para cadenas que solo empiecen por
  # GET /clients
  # GET /clients.json
  def index
    if params[:q]
      @clients = Client.where("nombre  LIKE '%"+params[:q]+"%'")
    else
      @clients = Client.all
    end
    #@clients = Client.all
    #@clients = Client.find(:all,:conditions => ['nombre LIKE ?', "#{params[:q]}%"],  :limit => 8, :order => 'nombre')
    respond_to do |format|
      format.html
      format.json { render :json => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    respond_to do |format|
      # if @client.valid? 
        if @client.save
          format.html { redirect_to @client, notice: 'Client was successfully created.' }
          format.json { render :show, status: :created, location: @client }
        else
          format.html { render :new }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      # else
      #   format.html { render :new }
      #   format.json { render json: @client.errors, status: :unprocessable_entity }
      # end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:nombre, :direccion, :telefono, :email)
    end
end
