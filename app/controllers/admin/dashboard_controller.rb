class Admin::DashboardController < ApplicationController
  # before_action :admin_only
  before_action :authenticate_admin!

  def index
    @top_five_customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
