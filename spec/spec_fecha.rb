require 'spec_helper'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Fecha
RSpec.describe ServicioSanitario::Fecha do
  # Se ejecuta antes de cada prueba para crear instancias de Fecha
  before(:each) do
    @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha1 = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
  end

  # Verifica que se puede crear una instancia de la clase Fecha
  it "Se espera poder crear una instancia de Fecha" do
    expect(@fecha).not_to be_nil
    expect(@fecha1).not_to be_nil
  end

  # Verifica que los valores de día, mes y año sean accesibles y correctos
  it "Se espera poder acceder a los atributos de la fecha (getters)" do
    expect(@fecha.dia).to eq(15)
    expect(@fecha.mes).to eq(11)
    expect(@fecha.anio).to eq(2024)
    expect(@fecha2.dia).to eq(19)
    expect(@fecha2.mes).to eq(07)
    expect(@fecha2.anio).to eq(2001)
  end

  # Verifica que la fecha se pueda representar correctamente como una cadena
  it "Se espera poder representar la fecha como cadena de manera correcta" do
    expect(@fecha.to_s).to eq("15/11/2024")
    expect(@fecha2.to_s).to eq("19/7/2001")
  end

  # Verifica que se pueda calcular la diferencia entre dos fechas
  it "Se espera poder calcular la diferencia entre dos fechas" do
    diferencia = ServicioSanitario.diferencia(@fecha, @fecha1)
    expect(diferencia).to eq("0 años, 0 meses, 0 días")
    
    diferencia = ServicioSanitario.diferencia(@fecha, @fecha2)
    expect(diferencia).to eq("23 años, 3 meses, 26 días")
  end
end
