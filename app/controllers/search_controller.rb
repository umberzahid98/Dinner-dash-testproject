# frozen_string_literal: true

# search controller
class SearchController < ApplicationController
  def index
    @query = Item.permited_items.ransack(params[:q])
    # it will return all of the search reslts
    @items = @query.result(distinct: true)
    @searched_category = params[:selected_category]
    @searched_category = '' if @searched_category.nil?
  end
end
