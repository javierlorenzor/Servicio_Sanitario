# frozen_string_literal: true

RSpec.describe ServicioSanitario do

  before(:each) do
    # Creación de dos instancias de la clase Hora con los mismos valores de hora, minuto y segundo
    @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora1 = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
    @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
  end

  context "Pruebas por defecto gema" do
    it "Se espera que la gema haga algo útil" do
      expect(true).to eq(true)
    end  
    
    it "Se espera que la version no este vacía" do
      expect(ServicioSanitario::VERSION).not_to be nil
    end
  end 

  context "Pruebas constante VERSION" do

    it "Se espera que la gema tenga una constante para indicar la version" do
      expect(defined?(ServicioSanitario::VERSION)).to eq("constant")
    end

    it "Se espera que la constante VERSION tenga el valor esperado" do
      expect(ServicioSanitario::VERSION).to eq('1.0.0')
    end

  end 
  

  context "Pruebas metodo DIFERENCIA HORAS " do
 
    it "Se espera poder calcular la diferencia entre dos horas" do
      diferencia = ServicioSanitario.diferencia_horas(@hora, @hora1)
      expect(diferencia).to eq("0 horas, 0 minutos, 0 segundos")

      diferencia1 = ServicioSanitario.diferencia_horas(@hora, @hora2)
      expect(diferencia1).to eq("1 horas, 50 minutos, 20 segundos")

      diferencia2 = ServicioSanitario.diferencia_horas(@hora, @hora3)
      expect(diferencia2).to eq("2 horas, 19 minutos, 30 segundos")
    end

 
    it "Se espera que se devuleva la alerta en función del tiempo de diferencia entre horas" do
      nivel = ServicioSanitario.obtener_nivel(@hora, @hora1)
      expect(nivel).to eq(ServicioSanitario::AZUL)
      expect(nivel).to be_a(Hash)

      nivel1 = ServicioSanitario.obtener_nivel(@hora, @hora2)
      expect(nivel1).not_to eq(ServicioSanitario::AZUL)

      nivel2 = ServicioSanitario.obtener_nivel(@hora, @hora3)
      expect(nivel2).to eq(ServicioSanitario::NEGRO)
      expect(nivel2).to be_a(Hash)
    end
  end 
end
