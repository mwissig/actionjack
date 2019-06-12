class Tictactoe < ApplicationRecord
  before_save :default_values
  def default_values
    self.turn ||= "x"
    self.x_wins ||= 0
    self.o_wins ||= 0
  end
end
