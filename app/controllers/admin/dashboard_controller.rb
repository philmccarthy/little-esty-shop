class Admin::DashboardController < Admin::BaseController

  def index
    @top_five_customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end

  private

  def admin_only
    render file: "/public/404" unless current_user.admin?
  end
end
