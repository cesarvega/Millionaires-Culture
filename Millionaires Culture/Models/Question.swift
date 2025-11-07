//
//  Question.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import Foundation

struct QuestionOption: Identifiable {
    let id = UUID()
    let textES: String
    let textEN: String
    
    func text(for language: AppLanguage) -> String {
        language == .spanish ? textES : textEN
    }
}

struct Question: Identifiable {
    let id = UUID()
    let questionTextES: String
    let questionTextEN: String
    let hintES: String
    let hintEN: String
    let options: [QuestionOption]
    let correctOptionID: UUID
    let prize: Int
    let questionIndex: Int
    
    func questionText(for language: AppLanguage) -> String {
        language == .spanish ? questionTextES : questionTextEN
    }
    
    func hint(for language: AppLanguage) -> String {
        language == .spanish ? hintES : hintEN
    }
    
    func correctAnswer(for language: AppLanguage) -> String {
        options.first(where: { $0.id == correctOptionID })?.text(for: language) ?? ""
    }
    
    func optionText(for id: UUID, language: AppLanguage) -> String? {
        options.first(where: { $0.id == id })?.text(for: language)
    }
}

struct QuestionContent {
    let questionES: String
    let questionEN: String
    let options: [(es: String, en: String)]
    let correctIndex: Int
    let hintES: String
    let hintEN: String
    
    func makeQuestion(prize: Int, index: Int) -> Question {
        var optionModels = options.map { QuestionOption(textES: $0.es, textEN: $0.en) }
        let correctID = optionModels[correctIndex].id
        optionModels.shuffle()
        return Question(
            questionTextES: questionES,
            questionTextEN: questionEN,
            hintES: hintES,
            hintEN: hintEN,
            options: optionModels,
            correctOptionID: correctID,
            prize: prize,
            questionIndex: index
        )
    }
}

// Question Pool - All available questions (Spanish & English)
let questionPool: [QuestionContent] = [
    QuestionContent(
        questionES: "¿Cuál es la capital de Francia?",
        questionEN: "What is the capital of France?",
        options: [
            ("Londres", "London"),
            ("Berlín", "Berlin"),
            ("París", "Paris"),
            ("Roma", "Rome")
        ],
        correctIndex: 2,
        hintES: "Es conocida como la 'Ciudad de la Luz'.",
        hintEN: "It is known as the 'City of Light.'"
    ),
    QuestionContent(
        questionES: "¿Qué planeta es conocido como el 'Planeta Rojo'?",
        questionEN: "Which planet is known as the 'Red Planet'?",
        options: [
            ("Júpiter", "Jupiter"),
            ("Marte", "Mars"),
            ("Venus", "Venus"),
            ("Saturno", "Saturn")
        ],
        correctIndex: 1,
        hintES: "Es el cuarto planeta desde el Sol.",
        hintEN: "It is the fourth planet from the Sun."
    ),
    QuestionContent(
        questionES: "¿Quién pintó la Mona Lisa?",
        questionEN: "Who painted the Mona Lisa?",
        options: [
            ("Vincent van Gogh", "Vincent van Gogh"),
            ("Pablo Picasso", "Pablo Picasso"),
            ("Leonardo da Vinci", "Leonardo da Vinci"),
            ("Claude Monet", "Claude Monet")
        ],
        correctIndex: 2,
        hintES: "Fue un polímata florentino del Renacimiento.",
        hintEN: "He was a Florentine polymath of the Renaissance."
    ),
    QuestionContent(
        questionES: "¿Cuántos continentes hay en la Tierra?",
        questionEN: "How many continents are there on Earth?",
        options: [
            ("5", "5"),
            ("6", "6"),
            ("7", "7"),
            ("8", "8")
        ],
        correctIndex: 2,
        hintES: "África, Antártida, Asia, Europa, América del Norte, Oceanía y América del Sur.",
        hintEN: "Africa, Antarctica, Asia, Europe, North America, Oceania, and South America."
    ),
    QuestionContent(
        questionES: "¿Cuál es el océano más grande del mundo?",
        questionEN: "What is the largest ocean in the world?",
        options: [
            ("Océano Atlántico", "Atlantic Ocean"),
            ("Océano Índico", "Indian Ocean"),
            ("Océano Pacífico", "Pacific Ocean"),
            ("Océano Ártico", "Arctic Ocean")
        ],
        correctIndex: 2,
        hintES: "Cubre aproximadamente un tercio de la superficie de la Tierra.",
        hintEN: "It covers roughly one third of Earth's surface."
    ),
    QuestionContent(
        questionES: "¿Cuál es el animal terrestre más rápido?",
        questionEN: "What is the fastest land animal?",
        options: [
            ("León", "Lion"),
            ("Gacela", "Gazelle"),
            ("Guepardo", "Cheetah"),
            ("Caballo", "Horse")
        ],
        correctIndex: 2,
        hintES: "Es un felino manchado.",
        hintEN: "It's a spotted feline."
    ),
    QuestionContent(
        questionES: "¿En qué país se encuentra la Gran Muralla China?",
        questionEN: "In which country is the Great Wall located?",
        options: [
            ("Japón", "Japan"),
            ("Corea del Sur", "South Korea"),
            ("China", "China"),
            ("India", "India")
        ],
        correctIndex: 2,
        hintES: "Es una de las Siete Maravillas del Mundo.",
        hintEN: "It is one of the Seven Wonders of the World."
    ),
    QuestionContent(
        questionES: "¿Cuántos huesos tiene el cuerpo humano adulto?",
        questionEN: "How many bones does the adult human body have?",
        options: [
            ("206", "206"),
            ("212", "212"),
            ("198", "198"),
            ("220", "220")
        ],
        correctIndex: 0,
        hintES: "Un bebé tiene más, pero algunos se fusionan.",
        hintEN: "A baby has more, but some fuse together."
    ),
    QuestionContent(
        questionES: "¿Qué gas respiramos los seres humanos?",
        questionEN: "Which gas do humans breathe?",
        options: [
            ("Dióxido de carbono", "Carbon dioxide"),
            ("Hidrógeno", "Hydrogen"),
            ("Nitrógeno", "Nitrogen"),
            ("Oxígeno", "Oxygen")
        ],
        correctIndex: 3,
        hintES: "Es esencial para la vida.",
        hintEN: "It is essential for life."
    ),
    QuestionContent(
        questionES: "¿Cuál es la montaña más alta del mundo?",
        questionEN: "What is the highest mountain in the world?",
        options: [
            ("K2", "K2"),
            ("Monte Everest", "Mount Everest"),
            ("Kangchenjunga", "Kangchenjunga"),
            ("Lhotse", "Lhotse")
        ],
        correctIndex: 1,
        hintES: "Se encuentra en el Himalaya.",
        hintEN: "It is located in the Himalayas."
    ),
    QuestionContent(
        questionES: "¿Quién escribió 'Don Quijote de la Mancha'?",
        questionEN: "Who wrote 'Don Quixote'?",
        options: [
            ("Gabriel García Márquez", "Gabriel García Márquez"),
            ("Federico García Lorca", "Federico García Lorca"),
            ("Miguel de Cervantes", "Miguel de Cervantes"),
            ("Jorge Luis Borges", "Jorge Luis Borges")
        ],
        correctIndex: 2,
        hintES: "Es una obra cumbre de la literatura española.",
        hintEN: "It is a cornerstone of Spanish literature."
    ),
    QuestionContent(
        questionES: "¿Cuál es el elemento químico con el símbolo 'O'?",
        questionEN: "Which chemical element has the symbol 'O'?",
        options: [
            ("Oro", "Gold"),
            ("Osmio", "Osmium"),
            ("Oxígeno", "Oxygen"),
            ("Oganesón", "Oganesson")
        ],
        correctIndex: 2,
        hintES: "Es el aire que respiras.",
        hintEN: "It's the air you breathe."
    ),
    QuestionContent(
        questionES: "¿Qué instrumento usa un sismógrafo para medir?",
        questionEN: "What does a seismograph measure?",
        options: [
            ("Viento", "Wind"),
            ("Temperatura", "Temperature"),
            ("Terremotos", "Earthquakes"),
            ("Presión", "Pressure")
        ],
        correctIndex: 2,
        hintES: "Registra la actividad sísmica.",
        hintEN: "It records seismic activity."
    ),
    QuestionContent(
        questionES: "¿Qué país es famoso por sus tulipanes y molinos de viento?",
        questionEN: "Which country is famous for tulips and windmills?",
        options: [
            ("Bélgica", "Belgium"),
            ("Alemania", "Germany"),
            ("Países Bajos", "Netherlands"),
            ("Dinamarca", "Denmark")
        ],
        correctIndex: 2,
        hintES: "Su capital es Ámsterdam.",
        hintEN: "Its capital is Amsterdam."
    ),
    QuestionContent(
        questionES: "¿Cuál es la capital de Australia?",
        questionEN: "What is the capital of Australia?",
        options: [
            ("Sídney", "Sydney"),
            ("Melbourne", "Melbourne"),
            ("Canberra", "Canberra"),
            ("Brisbane", "Brisbane")
        ],
        correctIndex: 2,
        hintES: "A menudo se confunde con una ciudad más grande.",
        hintEN: "It is often mistaken for a larger city."
    ),
    QuestionContent(
        questionES: "¿Cuál es el río más largo del mundo?",
        questionEN: "What is the longest river in the world?",
        options: [
            ("Amazonas", "Amazon"),
            ("Nilo", "Nile"),
            ("Yangtsé", "Yangtze"),
            ("Misisipi", "Mississippi")
        ],
        correctIndex: 1,
        hintES: "Fluye por el noreste de África.",
        hintEN: "It flows through northeastern Africa."
    ),
    QuestionContent(
        questionES: "¿Qué unidad se usa para medir la resistencia eléctrica?",
        questionEN: "Which unit is used to measure electrical resistance?",
        options: [
            ("Voltio", "Volt"),
            ("Amperio", "Ampere"),
            ("Ohmio", "Ohm"),
            ("Vatio", "Watt")
        ],
        correctIndex: 2,
        hintES: "Su símbolo se asemeja a una herradura.",
        hintEN: "Its symbol resembles a horseshoe."
    ),
    QuestionContent(
        questionES: "¿En qué año cayó el Muro de Berlín?",
        questionEN: "In what year did the Berlin Wall fall?",
        options: [
            ("1987", "1987"),
            ("1989", "1989"),
            ("1991", "1991"),
            ("1993", "1993")
        ],
        correctIndex: 1,
        hintES: "Sucedió poco antes del fin de la Guerra Fría.",
        hintEN: "It happened shortly before the end of the Cold War."
    ),
    QuestionContent(
        questionES: "¿Cuál es el metal más abundante en la corteza terrestre?",
        questionEN: "What is the most abundant metal in Earth's crust?",
        options: [
            ("Hierro", "Iron"),
            ("Cobre", "Copper"),
            ("Aluminio", "Aluminum"),
            ("Oro", "Gold")
        ],
        correctIndex: 2,
        hintES: "Se extrae de la bauxita.",
        hintEN: "It is extracted from bauxite."
    ),
    QuestionContent(
        questionES: "¿Cuántos lados tiene un heptágono?",
        questionEN: "How many sides does a heptagon have?",
        options: [
            ("6", "6"),
            ("7", "7"),
            ("8", "8"),
            ("9", "9")
        ],
        correctIndex: 1,
        hintES: "Su nombre comienza con la letra 'H'.",
        hintEN: "Its name starts with the letter 'H'."
    ),
    QuestionContent(
        questionES: "¿Qué país inventó la pizza moderna?",
        questionEN: "Which country invented modern pizza?",
        options: [
            ("España", "Spain"),
            ("Grecia", "Greece"),
            ("Italia", "Italy"),
            ("Portugal", "Portugal")
        ],
        correctIndex: 2,
        hintES: "Su ciudad de origen es Nápoles.",
        hintEN: "Its birthplace is Naples."
    ),
    QuestionContent(
        questionES: "¿Cuál es el idioma más hablado del mundo?",
        questionEN: "What is the most spoken language in the world?",
        options: [
            ("Inglés", "English"),
            ("Mandarín", "Mandarin"),
            ("Español", "Spanish"),
            ("Hindi", "Hindi")
        ],
        correctIndex: 1,
        hintES: "Es el idioma oficial de China.",
        hintEN: "It is the official language of China."
    ),
    QuestionContent(
        questionES: "¿Cuál es el órgano más grande del cuerpo humano?",
        questionEN: "What is the largest organ of the human body?",
        options: [
            ("Hígado", "Liver"),
            ("Piel", "Skin"),
            ("Pulmones", "Lungs"),
            ("Corazón", "Heart")
        ],
        correctIndex: 1,
        hintES: "Nos protege del entorno exterior.",
        hintEN: "It protects us from the outside environment."
    ),
    QuestionContent(
        questionES: "¿Qué científico propuso la teoría de la relatividad?",
        questionEN: "Which scientist proposed the theory of relativity?",
        options: [
            ("Isaac Newton", "Isaac Newton"),
            ("Albert Einstein", "Albert Einstein"),
            ("Marie Curie", "Marie Curie"),
            ("Niels Bohr", "Niels Bohr")
        ],
        correctIndex: 1,
        hintES: "Su apellido se asocia con la ecuación E=mc².",
        hintEN: "His surname is tied to the equation E=mc²."
    ),
    QuestionContent(
        questionES: "¿Cuál es la moneda oficial del Reino Unido?",
        questionEN: "What is the official currency of the United Kingdom?",
        options: [
            ("Euro", "Euro"),
            ("Libra esterlina", "Pound sterling"),
            ("Dólar", "Dollar"),
            ("Franco", "Franc")
        ],
        correctIndex: 1,
        hintES: "Su símbolo es £.",
        hintEN: "Its symbol is £."
    ),
    QuestionContent(
        questionES: "¿En qué continente se encuentra Egipto?",
        questionEN: "On which continent is Egypt located?",
        options: [
            ("Asia", "Asia"),
            ("África", "Africa"),
            ("Europa", "Europe"),
            ("Oceanía", "Oceania")
        ],
        correctIndex: 1,
        hintES: "Comparte el desierto del Sahara.",
        hintEN: "It shares the Sahara Desert."
    ),
    QuestionContent(
        questionES: "¿Cuál es el metal líquido a temperatura ambiente?",
        questionEN: "Which metal is liquid at room temperature?",
        options: [
            ("Mercurio", "Mercury"),
            ("Plomo", "Lead"),
            ("Aluminio", "Aluminum"),
            ("Estaño", "Tin")
        ],
        correctIndex: 0,
        hintES: "Su símbolo químico es Hg.",
        hintEN: "Its chemical symbol is Hg."
    ),
    QuestionContent(
        questionES: "¿Qué famoso físico formuló las leyes del movimiento?",
        questionEN: "Which famous physicist formulated the laws of motion?",
        options: [
            ("Galileo Galilei", "Galileo Galilei"),
            ("Isaac Newton", "Isaac Newton"),
            ("Albert Einstein", "Albert Einstein"),
            ("James Maxwell", "James Maxwell")
        ],
        correctIndex: 1,
        hintES: "Recibió el título de Sir.",
        hintEN: "He was knighted."
    ),
    QuestionContent(
        questionES: "¿Cuál es el desierto más grande del mundo?",
        questionEN: "What is the largest desert in the world?",
        options: [
            ("Sahara", "Sahara"),
            ("Gobi", "Gobi"),
            ("Antártida", "Antarctica"),
            ("Arabia", "Arabian")
        ],
        correctIndex: 2,
        hintES: "Es de hielo, no de arena.",
        hintEN: "It is icy, not sandy."
    ),
    QuestionContent(
        questionES: "¿Qué instrumento musical tiene teclas negras y blancas?",
        questionEN: "Which musical instrument has black and white keys?",
        options: [
            ("Violín", "Violin"),
            ("Piano", "Piano"),
            ("Guitarra", "Guitar"),
            ("Flauta", "Flute")
        ],
        correctIndex: 1,
        hintES: "Frédéric Chopin lo dominaba.",
        hintEN: "Frédéric Chopin mastered it."
    ),
    QuestionContent(
        questionES: "¿Qué gas compone la mayor parte de la atmósfera terrestre?",
        questionEN: "Which gas makes up most of Earth's atmosphere?",
        options: [
            ("Oxígeno", "Oxygen"),
            ("Nitrógeno", "Nitrogen"),
            ("Argón", "Argon"),
            ("Dióxido de carbono", "Carbon dioxide")
        ],
        correctIndex: 1,
        hintES: "Representa cerca del 78%.",
        hintEN: "It represents about 78%."
    ),
    QuestionContent(
        questionES: "¿Cuál es el animal nacional de Australia?",
        questionEN: "What is Australia's national animal?",
        options: [
            ("Koala", "Koala"),
            ("Canguro", "Kangaroo"),
            ("Emú", "Emu"),
            ("Dingo", "Dingo")
        ],
        correctIndex: 1,
        hintES: "Salta usando sus fuertes patas traseras.",
        hintEN: "It jumps using powerful hind legs."
    ),
    QuestionContent(
        questionES: "¿Qué ciudad se conoce como la 'Gran Manzana'?",
        questionEN: "Which city is known as the 'Big Apple'?",
        options: [
            ("Los Ángeles", "Los Angeles"),
            ("Chicago", "Chicago"),
            ("Nueva York", "New York"),
            ("Miami", "Miami")
        ],
        correctIndex: 2,
        hintES: "Es la ciudad más poblada de EE. UU.",
        hintEN: "It's the most populous city in the U.S."
    ),
    QuestionContent(
        questionES: "¿Cuál es la obra más famosa de William Shakespeare?",
        questionEN: "What is William Shakespeare's most famous play?",
        options: [
            ("Hamlet", "Hamlet"),
            ("Macbeth", "Macbeth"),
            ("Romeo y Julieta", "Romeo and Juliet"),
            ("Otelo", "Othello")
        ],
        correctIndex: 2,
        hintES: "Relata un amor prohibido en Verona.",
        hintEN: "It tells a forbidden love in Verona."
    ),
    QuestionContent(
        questionES: "¿Qué planeta tiene los anillos más visibles?",
        questionEN: "Which planet has the most visible rings?",
        options: [
            ("Saturno", "Saturn"),
            ("Urano", "Uranus"),
            ("Neptuno", "Neptune"),
            ("Júpiter", "Jupiter")
        ],
        correctIndex: 0,
        hintES: "Sus anillos son enormes y brillantes.",
        hintEN: "Its rings are massive and bright."
    ),
    QuestionContent(
        questionES: "¿Cuál es el punto más alto de América del Sur?",
        questionEN: "What is the highest point in South America?",
        options: [
            ("Aconcagua", "Aconcagua"),
            ("Chimborazo", "Chimborazo"),
            ("Huascarán", "Huascarán"),
            ("Illimani", "Illimani")
        ],
        correctIndex: 0,
        hintES: "Se encuentra en los Andes argentinos.",
        hintEN: "It lies in the Argentine Andes."
    ),
    QuestionContent(
        questionES: "¿Qué periodo histórico siguió a la Edad Media en Europa?",
        questionEN: "Which historical period followed the Middle Ages in Europe?",
        options: [
            ("Renacimiento", "Renaissance"),
            ("Ilustración", "Enlightenment"),
            ("Revolución Industrial", "Industrial Revolution"),
            ("Barroco", "Baroque")
        ],
        correctIndex: 0,
        hintES: "Leonardo da Vinci es un símbolo de esta era.",
        hintEN: "Leonardo da Vinci symbolizes this era."
    ),
    QuestionContent(
        questionES: "¿Cuál es el símbolo químico del sodio?",
        questionEN: "What is the chemical symbol for sodium?",
        options: [
            ("Na", "Na"),
            ("So", "So"),
            ("Sd", "Sd"),
            ("Sn", "Sn")
        ],
        correctIndex: 0,
        hintES: "Proviene del nombre latino 'natrium'.",
        hintEN: "It comes from the Latin name 'natrium'."
    ),
    QuestionContent(
        questionES: "¿Qué continente tiene la mayor cantidad de países?",
        questionEN: "Which continent has the most countries?",
        options: [
            ("Asia", "Asia"),
            ("África", "Africa"),
            ("Europa", "Europe"),
            ("América", "America")
        ],
        correctIndex: 1,
        hintES: "Tiene 54 naciones soberanas.",
        hintEN: "It has 54 sovereign nations."
    ),
    QuestionContent(
        questionES: "¿Cuál es la bebida nacional de Japón?",
        questionEN: "What is Japan's national beverage?",
        options: [
            ("Sake", "Sake"),
            ("Té verde", "Green tea"),
            ("Shochu", "Shochu"),
            ("Whisky", "Whisky")
        ],
        correctIndex: 0,
        hintES: "Se elabora a partir de arroz fermentado.",
        hintEN: "It's made from fermented rice."
    )
]

// Fixed prize ladder (15 levels)
let fixedPrizes = [100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]

// Safe levels (indices where prizes are guaranteed)
let safeLevels = [4, 9, 14] // Positions: $1,000, $32,000, $1,000,000
