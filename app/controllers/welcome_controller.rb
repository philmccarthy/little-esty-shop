class WelcomeController < ApplicationController
  before_action :set_items
  before_action :cart

  def index
  end

  private

  def set_items
    @items = Item.all
  end
end
