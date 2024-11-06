require 'spec_helper'
require 'ServicioSanitario/Fecha'
require 'ServicioSanitario'

# Descripción de las pruebas para la clase ServicioSanitario::Fecha
RSpec.describe ServicioSanitario::Fecha do
  # Se ejecuta antes de cada prueba para crear instancias de Fecha
  before(:each) do
    # Crear una instancia de Fecha con el día, mes y año especificados
    @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha1 = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
  end

  # Verifica que se puede crear una instancia de la clase Fecha
  it "Se espera poder crear una instancia de Fecha" do
    expect(@fecha).not_to be_nil
  end

  # Verifica que los valores de día, mes y año sean accesibles y correctos
  it "Se espera poder acceder a los atributos de la fecha (getters)" do
    expect(@fecha.dia).to eq(15)
    expect(@fecha.mes).to eq(11)
    expect(@fecha.anio).to eq(2024)
  end

  # Verifica que la fecha se pueda representar correctamente como una cadena
  it "Se espera poder representar la fecha como cadena de manera correcta" do
    expect(@fecha.to_s).to eq("15/11/2024")
  end

  # Verifica que se pueda calcular la diferencia entre dos fechas
  it "Se espera poder calcular la diferencia entre dos fechas" do
    # Se calcula la diferencia entre @fecha y @fecha1
    diferencia = ServicioSanitario.diferencia(@fecha, @fecha1)
    # Se espera que la diferencia sea "0 años, 0 meses, 0 días" porque son iguales
    expect(diferencia).to eq("0 años, 0 meses, 0 días")
  end
end
