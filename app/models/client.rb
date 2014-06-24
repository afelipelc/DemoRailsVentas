class Client < ActiveRecord::Base
	has_many :sales

	validates :nombre, :email, :presence => { message: "No puede dejarse vacío" }
end
