# frozen_string_literal: true

RSpec.describe ServicioSanitario do

  it "Se espera que la gema haga algo uutil" do
    expect(true).to eq(true)
  end
  
  it "Se espera que la version no este vacía" do
    expect(ServicioSanitario::VERSION).not_to be nil
  end

  it "Se espera que la gema tenga una constante para indicar la version" do
    expect(defined?(ServicioSanitario::VERSION)).to eq("constant")
  end

  it "Se espera que la constante VERSION tenga el valor '1.0.0'" do
    expect(ServicioSanitario::VERSION).to eq('1.0.0')
  end
  
end
