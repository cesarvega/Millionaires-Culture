//
//  Question.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let questionText: String
    let options: [String]
    let correctAnswer: String
    let hint: String
    let prize: Int
    let questionIndex: Int
    
    var shuffledOptions: [String] {
        options.shuffled()
    }
}

// Question Pool - All available questions
let questionPool: [QuestionContent] = [
    QuestionContent(question: "¿Cuál es la capital de Francia?", options: ["Londres", "Berlín", "París", "Roma"], answer: "París", hint: "Es conocida como la 'Ciudad de la Luz'."),
    QuestionContent(question: "¿Qué planeta es conocido como el 'Planeta Rojo'?", options: ["Júpiter", "Marte", "Venus", "Saturno"], answer: "Marte", hint: "Es el cuarto planeta desde el Sol."),
    QuestionContent(question: "¿Quién pintó la Mona Lisa?", options: ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci", "Claude Monet"], answer: "Leonardo da Vinci", hint: "Fue un polímata florentino del Renacimiento."),
    QuestionContent(question: "¿Cuántos continentes hay en la Tierra?", options: ["5", "6", "7", "8"], answer: "7", hint: "África, Antártida, Asia, Europa, América del Norte, Oceanía y América del Sur."),
    QuestionContent(question: "¿Cuál es el océano más grande del mundo?", options: ["Océano Atlántico", "Océano Índico", "Océano Pacífico", "Océano Ártico"], answer: "Océano Pacífico", hint: "Cubre aproximadamente un tercio de la superficie de la Tierra."),
    QuestionContent(question: "¿Cuál es el animal terrestre más rápido?", options: ["León", "Gacela", "Guepardo", "Caballo"], answer: "Guepardo", hint: "Es un felino manchado."),
    QuestionContent(question: "¿En qué país se encuentra la Gran Muralla China?", options: ["Japón", "Corea del Sur", "China", "India"], answer: "China", hint: "Es una de las Siete Maravillas del Mundo."),
    QuestionContent(question: "¿Cuántos huesos tiene el cuerpo humano adulto?", options: ["206", "212", "198", "220"], answer: "206", hint: "Un bebé tiene más, pero algunos se fusionan."),
    QuestionContent(question: "¿Qué gas respiramos los seres humanos?", options: ["Dióxido de carbono", "Hidrógeno", "Nitrógeno", "Oxígeno"], answer: "Oxígeno", hint: "Es esencial para la vida."),
    QuestionContent(question: "¿Cuál es la montaña más alta del mundo?", options: ["K2", "Monte Everest", "Kangchenjunga", "Lhotse"], answer: "Monte Everest", hint: "Se encuentra en el Himalaya."),
    QuestionContent(question: "¿Quién escribió 'Don Quijote de la Mancha'?", options: ["Gabriel García Márquez", "Federico García Lorca", "Miguel de Cervantes", "Jorge Luis Borges"], answer: "Miguel de Cervantes", hint: "Es una obra cumbre de la literatura española."),
    QuestionContent(question: "¿Cuál es el elemento químico con el símbolo 'O'?", options: ["Oro", "Osmio", "Oxígeno", "Oganesón"], answer: "Oxígeno", hint: "Es el aire que respiras."),
    QuestionContent(question: "¿Qué instrumento usa un sismógrafo para medir?", options: ["Viento", "Temperatura", "Terremotos", "Presión"], answer: "Terremotos", hint: "Registra la actividad sísmica."),
    QuestionContent(question: "¿Qué país es famoso por sus tulipanes y molinos de viento?", options: ["Bélgica", "Alemania", "Países Bajos", "Dinamarca"], answer: "Países Bajos", hint: "Su capital es Ámsterdam."),
    QuestionContent(question: "¿Cuál es la capital de Australia?", options: ["Sídney", "Melbourne", "Canberra", "Brisbane"], answer: "Canberra", hint: "A menudo se confunde con una ciudad más grande."),
    QuestionContent(question: "¿Cuál es el río más largo del mundo?", options: ["Amazonas", "Nilo", "Yangtsé", "Misisipi"], answer: "Nilo", hint: "Fluye por el noreste de África."),
    QuestionContent(question: "¿Qué unidad se usa para medir la resistencia eléctrica?", options: ["Voltio", "Amperio", "Ohmio", "Vatio"], answer: "Ohmio", hint: "Su símbolo se asemeja a una herradura."),
    QuestionContent(question: "¿En qué año cayó el Muro de Berlín?", options: ["1987", "1989", "1991", "1993"], answer: "1989", hint: "Sucedió poco antes del fin de la Guerra Fría."),
    QuestionContent(question: "¿Cuál es el metal más abundante en la corteza terrestre?", options: ["Hierro", "Cobre", "Aluminio", "Oro"], answer: "Aluminio", hint: "Se extrae de la bauxita."),
    QuestionContent(question: "¿Cuántos lados tiene un heptágono?", options: ["6", "7", "8", "9"], answer: "7", hint: "Su nombre comienza con la letra 'H'.")
]

struct QuestionContent {
    let question: String
    let options: [String]
    let answer: String
    let hint: String
}

// Fixed prize ladder (15 levels)
let fixedPrizes = [100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]

// Safe levels (indices where prizes are guaranteed)
let safeLevels = [4, 9, 14] // Positions: $1,000, $32,000, $1,000,000
