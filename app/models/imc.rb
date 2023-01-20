class Imc
  include ActiveModel::Validations
  extend ActiveModel::Translation

  IMC_GROUPS = {
    0...18.5 => {classification: "Magreza", obesity: "0"},
    18.5...25 => {classification: "Normal", obesity: "0"},
    25...30 => {classification: "Sobrepeso", obesity: "I"},
    30...40 => {classification: "Obesidade", obesity: "II"},
    40.. => {classification: "Obesidade Grave", obesity: "III"}
  }

  attr_reader :height, :weight

  validates :height, :weight, presence: true
  validates :height, numericality: {greater_than: 0}
  validates :weight, numericality: {greater_than: 0}

  def initialize(height:, weight:)
    @height = height
    @weight = weight
  end

  def value
    (weight / height**2).round(1)
  end

  def classification
    group[:classification]
  end

  def obesity
    group[:obesity]
  end

  private

  def group
    IMC_GROUPS.find { |range, group| break group if range === value }
  end
end
