class SearchesController < ApplicationController
  def show 
    @search = Search.new(term: serach_term) 
  end

  private

  def search_term
    params[:search]
  end
end

