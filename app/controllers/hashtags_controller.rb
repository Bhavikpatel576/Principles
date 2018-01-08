class HashtagsController < ApplicationController
  def show
    @hashtag = params[:id] 
    @result = ShoutSearchQuery.new(term: "##{@hashtag}").to_relation
  end
end
