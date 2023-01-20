class Imc
  include ActiveModel::Validations
  extend ActiveModel::Translation

  attr_reader :height, :weight

  validates :height, :weight, presence: true
  validates :height, numericality: { greater_than: 0 }
  validates :weight, numericality: { greater_than: 0 }

  def initialize(height:, weight:)
    @height = height
    @weight = weight
  end

  def classification
    if value < 18.5
      'Magreza'
    elsif value < 25
      'Normal'
    elsif value < 30
      'Sobrepeso'
    elsif value < 40
      'Obesidade'
    else
      'Obesidade Grave'
    end
  end

  def obesity
    if value < 18.5
       '0'
    elsif value < 25
       '0'
    elsif value < 30
       'I'
    elsif value < 40
       'II'
    else
       'III'
    end
  end

  def value
    (weight / height**2).round(1)
  end
end
