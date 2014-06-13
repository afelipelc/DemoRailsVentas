class Sale < ActiveRecord::Base
	#include ActiveModel::ForbiddenAttributesProtection
	belongs_to :client, :autosave => true
	has_many :saleDetails, :autosave => true #La clase relacionada se llama: SaleDetail
	accepts_nested_attributes_for :saleDetails
end
