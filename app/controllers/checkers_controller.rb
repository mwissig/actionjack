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
  @black_piece_starter_coordinates = %w(a2 a4 a6 a8 b1 b3 b5 b7 c2 c4 c6 c8)
    @red_piece_starter_coordinates = %w(f1 f3 f5 f7 g2 g4 g6 g8 h1 h3 h5 h7)
 end
end
@revcoords = @coords.reverse
  end

  def edit
  end

  def show
  end
end
