# frozen_string_literal: true

RSpec.describe ServicioSanitario do

  before(:each) do

    @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora1 = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
    @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
    @hora4 = ServicioSanitario::Hora.new(hora: 12, minuto: 0, segundo: 0)    
    @hora5 = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0) 

    @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha1 = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
    @fecha3 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2001)
    @fecha4 = ServicioSanitario::Fecha.new(dia: 10, mes: 12, anio: 2024)
  
    
    @dia_festivo1 = ServicioSanitario::Fecha.new(dia: 25, mes: 12, anio: 2024)
    @dia_festivo2 = ServicioSanitario::Fecha.new(dia: 1, mes: 1, anio: 2025)

    # Instancias de Hora
    @horario_apertura = ServicioSanitario::Hora.new(hora: 8, minuto: 0, segundo: 0)
    @horario_cierre = ServicioSanitario::Hora.new(hora: 20, minuto: 0, segundo: 0)


    # Instancias de Persona y Médico
    @paciente1 = ServicioSanitario::Persona.new("11111", "Carlos", "López", "M", @fecha1)
    @paciente2 = ServicioSanitario::Persona.new("22222", "Lucía", "Martínez", "F", @fecha2)

    @medico1 = ServicioSanitario::Medico.new("33333", "Alba", "Perez", "F", @fecha1, "Pediatría")
    @medico2 = ServicioSanitario::Medico.new("44444", "Miguel", "Tadeo", "M", @fecha2, "Pediatría")
    @medico3 = ServicioSanitario::Medico.new("55555", "Sofía", "Lopez", "F", @fecha3, "Cardiología")
    @medico4 = ServicioSanitario::Medico.new("66666", "Luis", "Gómez", "M", @fecha4, "Cardiología")
    @medico5 = ServicioSanitario::Medico.new("66666", "Oscar", "Lorenzo", "M", @fecha4, "General")


    # Asignación de paciente a médico
    @medico2.pacientes << @paciente1

    # Configuración de camas y servicio
    @camas = { 1 => nil, 2 => nil, 3 => nil }

    @servicio = ServicioSanitario::ServicioSalud.new(
      codigo: "SAL001",
      descripcion: "Servicio de Salud General",
      horario_apertura: @horario_apertura,
      horario_cierre: @horario_cierre,
      dias_festivos: [@dia_festivo1, @dia_festivo2],
      medicos: [@medico1, @medico2],
      camas: @camas
    )

    @camas2 = { 1 => nil, 2 => nil }
    @servicio2 = ServicioSanitario::ServicioSalud.new(
        codigo: "SAL002",
        descripcion: "Servicio de Salud Pediátrica",
        horario_apertura: @horario_apertura,
        horario_cierre: @horario_cierre,
        dias_festivos: [@dia_festivo1],
        medicos: [@medico1],
        camas: @camas2
    )
 
    @camas3 = { 1 => nil, 2 => nil, 3 => nil }
    @urgencias = ServicioSanitario::Urgencias.new(
      codigo: "URG001",
      descripcion: "Urgencias Generales",
      horario_apertura: @horario_apertura,
      horario_cierre: @horario_cierre,
      dias_festivos: [@dia_festivo1, @dia_festivo2],
      medicos: [@medico1, @medico2],
      camas: @camas3,
      camas_uci: 5  
    )

    @camas4 = { 1 => nil, 2 => nil, 3 => nil }
    @hospital = ServicioSanitario::Hospital.new(
      codigo: "HOSP001",
      descripcion: "Hospital General",
      horario_apertura: @horario_apertura,
      horario_cierre: @horario_cierre,
      dias_festivos: [@dia_festivo1, @dia_festivo2],
      medicos: [@medico1, @medico2],
      camas: @camas4,
      numero_plantas: 4
    )

    @servicio3 = ServicioSanitario::ServicioSalud.new(
    codigo: "SAL001",
    descripcion: "Servicio de Salud General",
    horario_apertura: @hora_apertura,
    horario_cierre: @hora_cierre,
    dias_festivos: [@dia_festivo1, @dia_festivo2],
    medicos: [@medico1, @medico2],
    camas: @camas
    )

    @camas5 = { 1 => nil, 2 => nil, 3 => nil }
    @servicio4 = ServicioSanitario::ServicioSalud.new(
      codigo: "SAL004",
      descripcion: "Servicio de Salud General",
      horario_apertura: @hora_apertura,
      horario_cierre: @hora_cierre,
      dias_festivos: [@dia_festivo1, @dia_festivo2],
      medicos: [@medico1, @medico2],
      camas: @camas5
  
    )

    @camas[1] = { paciente: @paciente1, hora_entrada: @hora1 }
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

  context "Pruebas CONSTANTES " do
    it "Se espera que las constantes esten correctamente definidas" do
      expect(ServicioSanitario::AZUL).to be_a(Hash)
      expect(ServicioSanitario::AZUL).to eq({ nivel: :I, categoria: :Reanimacion, tiempo_atencion: :Inmediato })
      expect(ServicioSanitario::ROJO).to be_a(Hash)
      expect(ServicioSanitario::ROJO).to eq({ nivel: :II, categoria: :Emergencia, tiempo_atencion: '7 minutos' })
      expect(ServicioSanitario::NARANJA).to be_a(Hash)
      expect(ServicioSanitario::NARANJA).to eq({ nivel: :III, categoria: :Urgente, tiempo_atencion: '30 minutos' })
      expect(ServicioSanitario::VERDE).to be_a(Hash)
      expect(ServicioSanitario::VERDE).to eq({ nivel: :IV, categoria: :Menos_urgente, tiempo_atencion: '45 minutos' })
      expect(ServicioSanitario::NEGRO).to be_a(Hash)
      expect(ServicioSanitario::NEGRO).to eq({ nivel: :V, categoria: :No_urgente, tiempo_atencion: '60 minutos' })
    end
  end 

  context "Pruebas metodo DIFERENCIA FECHAS " do
    it "Se espera poder calcular la diferencia entre dos fechas" do
      diferencia = ServicioSanitario.diferencia(@fecha, @fecha1)
      expect(diferencia).to eq("0 años, 0 meses, 0 días")
      
      diferencia1 = ServicioSanitario.diferencia(@fecha, @fecha2)
      expect(diferencia1).to eq("23 años, 3 meses, 26 días")

      diferencia3 = ServicioSanitario.diferencia(@fecha2, @fecha3)
      expect(diferencia3).to eq("0 años, 2 meses, 4 días")

      diferencia4 = ServicioSanitario.diferencia(@fecha4, @fecha2)
      expect(diferencia4).to eq("23 años, 4 meses, 21 días")
    end
  end 

  context "Pruebas metodo OBTENER NIVEL " do
    it " Se espera que retorne nivel AZUL para una diferencia de 0 a 6 minutos" do
      resultado = ServicioSanitario.obtener_nivel(@hora, @hora1)
      expect(resultado).to eq(ServicioSanitario::AZUL)
    end

    it "Se espera que retorne nivel ROJO para una diferencia de 7 a 30 minutos" do
      hora_actual = ServicioSanitario::Hora.new(hora: 12, minuto: 37, segundo: 45)
      resultado = ServicioSanitario.obtener_nivel(@hora, hora_actual)
      expect(resultado).to eq(ServicioSanitario::ROJO)
    end

    it "Se espera que retorne nivel NARANJA para una diferencia de 31 a 45 minutos" do
      hora_actual = ServicioSanitario::Hora.new(hora: 13, minuto: 1, segundo: 45)
      resultado = ServicioSanitario.obtener_nivel(@hora, hora_actual)
      expect(resultado).to eq(ServicioSanitario::NARANJA)
    end

    it "Se espera que retorne nivel VERDE para una diferencia de 46 a 60 minutos" do
      hora_actual = ServicioSanitario::Hora.new(hora: 13, minuto: 16, segundo: 45)
      resultado = ServicioSanitario.obtener_nivel(@hora, hora_actual)
      expect(resultado).to eq(ServicioSanitario::VERDE)
    end

    it "Se espera que retorne nivel NEGRO para una diferencia mayor a 60 minutos" do
      hora_actual = ServicioSanitario::Hora.new(hora: 13, minuto: 31, segundo: 45)
      resultado = ServicioSanitario.obtener_nivel(@hora, hora_actual)
      expect(resultado).to eq(ServicioSanitario::NEGRO)
    end
  end 

  context "Pruebas metodo fusion de Servisios sanitarios " do
    it "Se espera que fusione correctamente los códigos y descripciones de los servicios" do
      fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)
      expect(fusionado.codigo).to eq("SAL001-SAL002")
      expect(fusionado.descripcion).to eq("Servicio de Salud General & Servicio de Salud Pediátrica")
    end

    it "Se espera que combine correctamente los días festivos sin duplicados" do
      fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)
      expect(fusionado.dias_festivos).to contain_exactly(@dia_festivo1, @dia_festivo2)
    end

    it "Se espera combinar correctamente las camas disponibles" do
      fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)
      expect(fusionado.camas.keys).to contain_exactly(1, 2, 3)
    end

    it "Se espera dar un error si uno de los servicios no es una instancia válida" do
      expect {
        ServicioSanitario.fusionar_servicios(@servicio, "No es un servicio")
      }.to raise_error(ArgumentError, "Ambos argumentos deben ser instancias de ServicioSalud")
    end

    it "Se espera que tome el horario de apertura más temprano y el horario de cierre más tardío" do
      servicio_fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)
      expect(servicio_fusionado.horario_apertura).to eq(@horario_apertura)
      expect(servicio_fusionado.horario_cierre).to eq(@horario_cierre)
    end

    it "Se espera que combine y elimine duplicados de días festivos" do
      servicio_fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)
      expect(servicio_fusionado.dias_festivos).to match_array([@dia_festivo1, @dia_festivo2])
    end

    it "Se espera que combine las listas de médicos" do
      servicio_fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)
      expect(servicio_fusionado.medicos).to match_array([@medico1, @medico2, @medico1])
    end

  end 

  context "POLIMORFISMO " do
    it "Se espera que fusione correctamente dos servicios del mismo tipo" do
      servicio_fusionado = ServicioSanitario.fusionar_servicios(@servicio, @servicio2)

      expect(servicio_fusionado.codigo).to eq("SAL001-SAL002")
      expect(servicio_fusionado.descripcion).to eq("Servicio de Salud General & Servicio de Salud Pediátrica")
      expect(servicio_fusionado.dias_festivos).to contain_exactly(@dia_festivo1, @dia_festivo2)
      expect(servicio_fusionado.medicos).to include(@medico1, @medico2)
      expect(servicio_fusionado.num_camas_libres).to eq(2) 
    end

    it "Se espera que lance un error si se intenta fusionar objetos que no son instancias de ServicioSalud" do
      expect {
        ServicioSanitario.fusionar_servicios(@fecha, @fecha1)
      }.to raise_error(ArgumentError, "Ambos argumentos deben ser instancias de ServicioSalud")
    end

    it "Se espera que lance un error si se intenta fusionar objetos que no son instancias de ServicioSalud" do
      expect {
        ServicioSanitario.fusionar_servicios(@hora, @hora1)
      }.to raise_error(ArgumentError, "Ambos argumentos deben ser instancias de ServicioSalud")
    end

    it "Se espera que fusione  Hospital y  Urgencias correctamente" do
      servicio_fusionado = ServicioSanitario.fusionar_servicios(@hospital, @urgencias)

      expect(servicio_fusionado).to be_a(ServicioSanitario::ServicioSalud)
      expect(servicio_fusionado.codigo).to eq("HOSP001-URG001")
      expect(servicio_fusionado.descripcion).to eq("Hospital General & Urgencias Generales")
      expect(servicio_fusionado.medicos).to include(@medico1, @medico2)
      expect(servicio_fusionado.num_camas_libres).to eq(3) 
      expect(servicio_fusionado.dias_festivos).to eq([@dia_festivo1, @dia_festivo2])
    end

    it "Se espera que ignore atributos específicos de Hospital y Urgencias en la fusión" do
      servicio_fusionado = ServicioSanitario.fusionar_servicios(@hospital, @urgencias)

      # Asegura que los atributos específicos de cada clase no están presentes en el servicio fusionado
      expect(servicio_fusionado).not_to respond_to(:camas_uci)
      expect(servicio_fusionado).not_to respond_to(:numero_plantas)
    end
  end 

  context "Pruebas indice de capacidad de respuesta " do
    it "Se espera que calcule el índice como excelente (3) cuando el tiempo de ocupación y el ratio son excelentes" do
      @servicio.medicos << @medico1 # Ratio 1:1 (excelente)
      @servicio.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0) # Tiempo <= 15 minutos
      indice = ServicioSanitario.calcular_indice_respuesta(@servicio)
      expect(indice).to eq(3)
    end
  
    it "Se espera que calcule el índice como bueno (2) cuando ambos indicadores son buenos" do
      @servicio.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 10, minuto: 0, segundo: 0) # Tiempo entre 15 y 30 minutos
      @servicio.medicos.pop # Ratio 1:2 (bueno)
      indice = ServicioSanitario.calcular_indice_respuesta(@servicio)
      expect(indice).to eq(2)
    end
  
    it "Se espera que calcule el índice como aceptable (1) cuando ambos indicadores son aceptables" do
      @servicio.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 7, minuto: 0, segundo: 0) # Tiempo >= 30 minutos
      @servicio.medicos.pop # Ratio 1:3 (aceptable)
      indice = ServicioSanitario.calcular_indice_respuesta(@servicio)
      expect(indice).to eq(2)
    end
  
    it "Se espera que se maneja correctamente cuando no hay pacientes asignados (índice por defecto excelente)" do
      @servicio.camas.each { |k, _| @servicio.camas[k] = nil } # Sin pacientes
      indice = ServicioSanitario.calcular_indice_respuesta(@servicio)
      expect(indice).to eq(3)
    end

    
  end 

  context "Pruebas selecion de mejor servicio" do 
    it "Se espera que seleccione el servicio con el mayor índice de capacidad de respuesta" do
      @servicio.medicos << @medico1
      @servicio.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0)
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio(@servicio, @servicio2)
      expect(mejor_servicio).to eq(@servicio)
    end
  
    it "Se espera que maneje correctamente cuando hay un empate en el índice" do
      @servicio.medicos << @medico1
      @servicio.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0)
      @servicio3.medicos << @medico1
      @servicio3.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0)
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio(@servicio, @servicio3)
      expect(mejor_servicio).to eq(@servicio) # El primero por defecto
    end
  
    it "Se espera que lance un error si algún argumento no es un servicio válido" do
      expect { ServicioSanitario.seleccionar_mejor_servicio(@servicio, "No es un servicio") }.to raise_error(ArgumentError)
    end
    it "Se espera que devuelva nil si no se pasan servicios" do
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio
      expect(mejor_servicio).to be_nil
    end
  
    it "Se espera que seleccione correctamente el único servicio si solo hay uno" do
      @servicio.medicos << @medico1
      @servicio.camas[1][:ingreso] = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0)
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio(@servicio)
      expect(mejor_servicio).to eq(@servicio)
    end

  end 

  context " Pruebas que selecionar el mejor servicio UCI" do
    it "Se espera seleccionar el servicio de urgencias con mayor índice de capacidad de respuesta" do
      servicios = [@servicio, @servicio2, @servicio3, @urgencias]
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio_uci(servicios)
      expect(mejor_servicio).to eq(@urgencias)
    end

    it "Se espera devolver nil si no hay servicios con camas UCI" do
      servicios_sin_uci = [@servicio, @servicio2, @servicio3]  # No hay servicios de urgencias con camas UCI
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio_uci(servicios_sin_uci)
      expect(mejor_servicio).to be_nil
    end

    it "Se espera seleccionar el servicio correcto cuando hay varios servicios con camas UCI" do
      # Crear otro servicio de urgencias con camas UCI, pero con menor capacidad de respuesta
      otro_servicio_urgencias = ServicioSanitario::Urgencias.new(
        codigo: "URG002",
        descripcion: "Urgencias Especializadas",
        horario_apertura: @horario_apertura,
        horario_cierre: @horario_cierre,
        dias_festivos: [@dia_festivo1],
        medicos: [@medico1],
        camas: @camas2,
        camas_uci: 3
      )

      servicios = [@servicio, @servicio2, @servicio3, @urgencias, otro_servicio_urgencias]
      mejor_servicio = ServicioSanitario.seleccionar_mejor_servicio_uci(servicios)
      expect(mejor_servicio).to eq(@urgencias)
    end
  end 

  context "Pruebas porcentaje camas libres" do 
    it "Se espera que calcule correctamente el porcentaje de camas libres para un servicio con una cama libre" do
      @servicio4.asignar_cama(@paciente1)
      @servicio4.asignar_cama(@paciente2)
      resultado = ServicioSanitario.porcent_camas([@servicio4])
      
      expect(resultado["SAL004"]).to eq(33)
    end

    it "Se espera que calcule correctamente el porcentaje de camas libres para un servicio con ninguna de las camas libre" do
      @servicio4.asignar_cama(@paciente1)
      @servicio4.asignar_cama(@paciente2)
      @servicio4.asignar_cama(@paciente2)
      resultado = ServicioSanitario.porcent_camas([@servicio4])
      
      expect(resultado["SAL004"]).to eq(0)
    end

    it "Se espera que calcule correctamente el porcentaje de camas libres para un servicio con una cama libre" do
      @servicio4.asignar_cama(@paciente1)
      resultado = ServicioSanitario.porcent_camas([@servicio4])
      expect(resultado["SAL004"]).to eq(67)
    end

    it "Se espera que calcule correctamente el porcentaje de camas libres para un servicio con todas las camas libres" do
      resultado = ServicioSanitario.porcent_camas([@servicio4])
      expect(resultado["SAL004"]).to eq(100)
    end

  end 

  context "Pruebas para porcentaje de medicos por especialidad" do 
    it "calcula correctamente el porcentaje de facultativos por especialidad para varios servicios con distintas especialidades" do
      @servicio.asignar_medico(@medico1, @paciente2)
      @servicio.asignar_medico(@medico1, @paciente2)
      resultado = ServicioSanitario.porcent_especialidad([@servicio1, @servicio2])
    
      expect(resultado["SAL001"]["Pediatría"]).to eq(100.0)
      expect(resultado["SAL002"]["Pediatría"]).to eq(0)
    end
  end 

end
