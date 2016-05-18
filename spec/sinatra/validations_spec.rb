require "sinatra/validations"

describe Sinatra::Validations do
  it "casts the param to String when type is String" do
    params = { test: 1 }

    subject.validate(params, :test, type: String)

    expect(params[:test]).to eq("1")
  end

  it "casts the param to Integer when type is Integer" do
    params = { test: "1" }

    subject.validate(params, :test, type: Integer)

    expect(params[:test]).to eq(1)
  end

  it "returns an error when the param can't be coerced into type" do
    expect { subject.validate({ test: [] }, :test, type: Integer) }.
      to raise_error(Sinatra::Validations::InvalidParameter)
  end

  it "returns an error when the param is not an Integer or a String an cast isn't false" do
    expect { subject.validate({ test: [] }, :test, type: Array) }.
      to raise_error(Sinatra::Validations::InvalidParameter)
  end

  context "when the param is nil" do
    it "sets it to the default value" do
      params = {}

      subject.validate(params, :test, default: "yay")

      expect(params[:test]).to eq("yay")
    end

    it "returns nil when nil is provided as the default value" do
      params = {}

      subject.validate(params, :test, default: nil)

      expect(params.key?(:test)).to be true
    end

    context "and no default value is provided" do
      it "returns an error" do
        expect { subject.validate({}, :test) }.
          to raise_error(Sinatra::Validations::InvalidParameter)
      end
    end
  end

  context "when cast is false" do
    it "returns an error when the param doesn't meet the expected type" do
      expect { subject.validate({ test: "0" }, :test, type: Integer, cast: false) }.
        to raise_error(Sinatra::Validations::InvalidParameter)
    end
  end
end
