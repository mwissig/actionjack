class CheckersController < ApplicationController
  def new
  end

  def index
    @nums = (1..8).to_a
@lets = ('a'..'h').to_a
@odds = %w(a c e g)
@coords = []
@lets.each do |let|
 @nums.each do |num|
  @coords.push(let + num.to_s)
 end
end

  end

  def edit
  end

  def show
  end
end
