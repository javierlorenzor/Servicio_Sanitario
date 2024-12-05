# frozen_string_literal: true

RSpec.describe ServicioSanitario do

  before(:each) do

    @hora = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora1 = ServicioSanitario::Hora.new(hora: 12, minuto: 30, segundo: 45)
    @hora2 = ServicioSanitario::Hora.new(hora: 10, minuto: 40, segundo: 25)
    @hora3 = ServicioSanitario::Hora.new(hora: 14, minuto: 50, segundo: 15)
    @hora4 = ServicioSanitario::Hora.new(hora: 10, minuto: 10, segundo: 25)

    @fecha = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha1 = ServicioSanitario::Fecha.new(dia: 15, mes: 11, anio: 2024)
    @fecha2 = ServicioSanitario::Fecha.new(dia: 19, mes: 7, anio: 2001)
    @fecha3 = ServicioSanitario::Fecha.new(dia: 23, mes: 9, anio: 2001)
    @hora4 = ServicioSanitario::Hora.new(hora: 12, minuto: 0, segundo: 0)    # Hora de entrada para prueba de 40 minutos de ocupación
    @hora5 = ServicioSanitario::Hora.new(hora: 12, minuto: 15, segundo: 0)    
    
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
    @camas5 = { 1 => nil, 2 => nil, 3 => nil }
    @servicio3 = ServicioSanitario::ServicioSalud.new(
    codigo: "SAL001",
    descripcion: "Servicio de Salud General",
    horario_apertura: @hora_apertura,
    horario_cierre: @hora_cierre,
    dias_festivos: [@dia_festivo1, @dia_festivo2],
    medicos: [@medico1, @medico2],
    camas: @camas
  )

  # Añadir pacientes a las camas (si es necesario para la prueba)
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
      expect(diferencia4).to eq("23 años, 3 meses, 19 días")
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
    it "debería devolver 3 (exelente) si el tiempo de ocupación es <= 15 minutos y el ratio es exelente " do
      # Establecemos los valores necesarios para los cálculos de la función
      @servicio.camas = { 1 => { paciente: @paciente1 }, 2 => nil, 3 => { paciente: @paciente2 } }
      @servicio.instance_variable_set(:@pacientes_asignados, 6) # 6 pacientes

      # Definir una ocupación media mayor o igual a 30 minutos
      expect(ServicioSanitario.indice_capacidad_respuesta(@servicio3)).to eq(3)  # Aceptable
    end
    it 'debería devolver 1 (aceptable) si el tiempo de ocupación es >= 30 minutos y el ratio es aceptable' do
      # Asignación de camas y pacientes
      @camas5[1] = { paciente: @paciente1, hora_entrada: @hora4 }

      # Aquí establecemos un tiempo de ocupación de más de 30 minutos
      # Para este ejemplo, simulamos que la ocupación es de 40 minutos y que el ratio de facultativos es adecuado
      resultado = ServicioSanitario.indice_capacidad_respuesta(@servicio3)

      expect(resultado).to eq(1)  # Aceptable
    end

    it 'debería devolver 2 (bueno) si el tiempo de ocupación es entre 15 y 30 minutos y el ratio es bueno' do
      # Simulamos una ocupación de 25 minutos y ratio de facultativos adecuado
      @camas5[1] = { paciente: @paciente2, hora_entrada: @hora5 }

      resultado = ServicioSanitario.indice_capacidad_respuesta(@servicio3)

      expect(resultado).to eq(2)  # Bueno
    end

    it 'debería devolver 3 (excelente) si el tiempo de ocupación es < 15 minutos y el ratio es excelente' do
      # Simulamos que el tiempo de ocupación es menor a 15 minutos y el ratio es excelente
      @camas5[1] = { paciente: @paciente1, hora_entrada: @hora1 }

      resultado = ServicioSanitario.indice_capacidad_respuesta(@servicio3)

      expect(resultado).to eq(3)  # Excelente
    end

    
  end 
end
