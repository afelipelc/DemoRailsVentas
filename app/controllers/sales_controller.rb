class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    # asociar un nuevo cliente
    @sale.client = Client.new

    #@sale.saleDetails << SaleDetail.new(:product_id => 1, :preciounitario=>100, :cantidad => 1, :importe => 100)
    #@sale.saleDetails << SaleDetail.new(:product_id => 4, :preciounitario=>234, :cantidad => 2, :importe => 468)

  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create

#strong parameters >> http://edgeapi.rubyonrails.org/classes/ActionController/StrongParameters.html
#se habilito strong parameters en el modelo
    @sale = Sale.new(sale_params)

    client = Client.new(client_params)
    
    #al recibir los datos, comprobar si existe el cliente, entonces se pueden actualizar sus datos

    # si no existe el cliente, registrar un nuevo
    if @sale.client_id.nil?
      @sale.client = client
    else
      @sale.client.nombre = client.nombre ##si el cliente ya existe, se actualiza al nuevo valor recibido
      @sale.client.direccion = client.direccion
    end

    puts "Datos recibidos de la nueva venta"
 #   @sale.client.nombre = client.nombre ##si el cliente ya existe, se actualiza al nuevo valor recibido
    puts "Cliente>> " + @sale.client_id.to_s + @sale.client.nombre
    puts "Productos recibidos: " 
    
    
    @sale.saleDetails.each do |item|
    # #params[:saledetails].each do |item|
       puts "id: " + item.product_id.to_s + ", p. u: " + item.preciounitario.to_s + ", cantidad: " + item.cantidad.to_s + ", importe: " + item.importe.to_s
    end 

    

     respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
     end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:client_id, :fecha, :importe, :saleDetails_attributes => [:product_id, :preciounitario, :cantidad, :importe])
    end

    #definir mis parametros que debo recibir para cliente
    # y para los detalles
     def client_params
       params.require(:client).permit(:id, :nombre, :direccion, :telefono, :email)
     end

     # def details_params
     #   params.require(:saleDetails_attributes).permit({:product_id => []}, {:preciounitario => []}, {:cantidad => []}, {:importe=> []})
     # end
end
