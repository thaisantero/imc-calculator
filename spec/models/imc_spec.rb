require "rails_helper"

RSpec.describe Imc, type: :model do
  describe "validations" do
    context "when height is nil" do
      it "is not valid" do
        imc = Imc.new(height: nil, weight: 80)

        expect(imc.valid?).to eq false
      end
    end

    context "when weight is nil" do
      it "is not valid" do
        imc = Imc.new(height: 2, weight: nil)

        expect(imc.valid?).to eq false
      end
    end

    context "when height is a text" do
      it "is not valid" do
        imc = Imc.new(height: "abc", weight: 80)

        expect(imc.valid?).to eq false
      end
    end

    context "when weight is a text" do
      it "is not valid" do
        imc = Imc.new(height: 2, weight: "abc")

        expect(imc.valid?).to eq false
      end
    end

    context "when height and weight are positive values" do
      it "is valid" do
        imc = Imc.new(height: 2, weight: 80)

        expect(imc.valid?).to eq true
      end
    end

    context "when height is a negative value" do
      it "is not valid" do
        imc = Imc.new(height: -2, weight: 80)

        expect(imc.valid?).to eq false
      end
    end

    context "when weight is a negative value" do
      it "is not valid" do
        imc = Imc.new(height: 2, weight: -80)

        expect(imc.valid?).to eq false
      end
    end

    context "when height is zero" do
      it "is not valid" do
        imc = Imc.new(height: 0, weight: 80)

        expect(imc.valid?).to eq false
      end
    end

    context "when weight is zero" do
      it "is not valid" do
        imc = Imc.new(height: 2, weight: 0)

        expect(imc.valid?).to eq false
      end
    end

    context "when height is a float number" do
      it "is not valid" do
        imc = Imc.new(height: 1.8123, weight: 80)

        expect(imc.valid?).to eq true
      end
    end

    context "when weight is a float number" do
      it "is not valid" do
        imc = Imc.new(height: 2, weight: 80.234)

        expect(imc.valid?).to eq true
      end
    end
  end

  describe "#value" do
    it "returns imc value when integer height and weight passed" do
      imc = Imc.new(height: 2, weight: 80)

      imc_value = imc.value

      expect(imc_value).to eq 20
    end

    it "returns imc value when float height and weight passed" do
      imc = Imc.new(height: 1.7, weight: 93.6)

      imc_value = imc.value

      expect(imc_value).to eq 32.4
    end
  end

  describe "#classification" do
    it "returns 'Magreza' when imc value is less than 18.5" do
      imc = Imc.new(height: 2, weight: 50)

      imc_classification = imc.classification

      expect(imc_classification).to eq "Magreza"
    end

    it "returns 'Normal' when imc value is between 18.5 and 25" do
      imc = Imc.new(height: 2, weight: 80)

      imc_classification = imc.classification

      expect(imc_classification).to eq "Normal"
    end

    it "returns 'Sobrepeso' when imc value is between 25 and 30" do
      imc = Imc.new(height: 2, weight: 100)

      imc_classification = imc.classification

      expect(imc_classification).to eq "Sobrepeso"
    end

    it "returns 'Obesidade' when imc value is between 30 and 40" do
      imc = Imc.new(height: 2, weight: 125)

      imc_classification = imc.classification

      expect(imc_classification).to eq "Obesidade"
    end

    it "returns 'Obesidade Grave' when imc value is greater than 40" do
      imc = Imc.new(height: 2, weight: 180)

      imc_classification = imc.classification

      expect(imc_classification).to eq "Obesidade Grave"
    end
  end

  describe "#obesity" do
    it "returns '0' when imc value is less than 18.5" do
      imc = Imc.new(height: 2, weight: 50)

      imc_obesity = imc.obesity

      expect(imc_obesity).to eq "0"
    end

    it "returns '0' when imc value is between 18.5 and 25" do
      imc = Imc.new(height: 2, weight: 80)

      imc_obesity = imc.obesity

      expect(imc_obesity).to eq "0"
    end

    it "returns 'I' when imc value is between 25 and 30" do
      imc = Imc.new(height: 2, weight: 100)

      imc_obesity = imc.obesity

      expect(imc_obesity).to eq "I"
    end

    it "returns 'II' when imc value is between 30 and 40" do
      imc = Imc.new(height: 2, weight: 125)

      imc_obesity = imc.obesity

      expect(imc_obesity).to eq "II"
    end

    it "returns 'III' when imc value is greater than 40" do
      imc = Imc.new(height: 2, weight: 180)

      imc_obesity = imc.obesity

      expect(imc_obesity).to eq "III"
    end
  end
end
