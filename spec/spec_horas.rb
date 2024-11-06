require 'spec_helper'
require 'ServicioSanitario/Horas'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Hora
RSpec.describe ServicioSanitario::Hora do
  # Se ejecuta antes de cada prueba para inicializar las instancias necesarias de Hora
  before(:each) do
    # Creación de dos instancias de la clase Hora con los mismos valores de hora, minuto y segundo
    @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora1 = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
  end
  
  # Prueba para verificar que la instancia de Hora se crea correctamente
  it "Se espera poder crear una instancia de Hora" do
    # Comprobamos que la variable @hora no sea nil, lo que indica que se creó una instancia de la clase
    expect(@hora).not_to be_nil
  end

  # Prueba para verificar que los atributos hora, minuto y segundo se pueden acceder correctamente
  it "Se espera que se pueda acceder a la hora , minutos y segundos correctamente" do
    # Comprobamos que los atributos de la instancia de Hora son los valores esperados
    expect(@hora.hora).to eq(12)
    expect(@hora.minuto).to eq(30)
    expect(@hora.segundo).to eq(45)
  end

  # Prueba para verificar que el formato de la hora es correcto
  it "Se espera que el formato de la hora sea correcto" do
    # Comprobamos que el método to_s devuelva el formato correcto
    expect(@hora.to_s).to eq("12:30:45")
  end

  # Prueba para calcular la diferencia entre dos horas
  it "Se espera poder calcular la diferencia entre dos horas" do
    # Llamamos al método diferencia_horas para obtener la diferencia entre las dos horas
    diferencia = ServicioSanitario.diferencia_horas(@hora, @hora1)
    # Comprobamos que la diferencia entre las dos horas sea 0 horas, 0 minutos y 0 segundos
    expect(diferencia).to eq("0 horas, 0 minutos, 0 segundos")
  end

  # Prueba para verificar que se devuelve la alerta correcta según el tiempo de diferencia entre las horas
  it "Se espera que se devuleva la alerta en función del tiempo de diferencia entre horas" do
    # Llamamos al método obtener_nivel para obtener el nivel de alerta basado en la diferencia entre las dos horas
    nivel = ServicioSanitario.obtener_nivel(@hora, @hora1)
    # Comprobamos que el nivel devuelto es el nivel AZUL, ya que las horas son iguales
    expect(nivel).to eq(ServicioSanitario::AZUL)
  end
end
