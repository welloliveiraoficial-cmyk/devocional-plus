import '../models/devotional.dart';

const List<String> devotionalThemes = [
  'Fé',
  'Esperança',
  'Amor',
  'Família',
  'Ansiedade',
  'Gratidão',
  'Recomeço',
  'Momentos difíceis',
];

final List<Devotional> devotionals = [

  Devotional(
    id: 'ansiedade_1',
    title: 'Quando o coração está cansado',
    theme: 'Ansiedade',
    verseText:
        'Lançando sobre ele toda a vossa ansiedade, porque ele tem cuidado de vós.',
    verseRef: '1 Pedro 5:7',
    reflection:
        'Existem dias em que carregamos pesos que ninguém consegue enxergar. Sorrimos por fora, mas por dentro estamos lutando batalhas silenciosas. Deus conhece cada pensamento, cada lágrima e cada preocupação que você guarda no coração. Ele não pede que você enfrente tudo sozinho, Ele convida você a entregar seus fardos a Ele.',
    application:
        'Hoje, entregue a Deus uma preocupação específica que tem tirado sua paz e confie que Ele está cuidando de você.',
    prayer:
        'Senhor, meu coração está cansado, mas eu escolho confiar em Ti. Tira de mim todo peso que não consigo carregar e enche minha vida com a Tua paz. Amém.',
    readingMinutes: 4,
  ),

  Devotional(
    id: 'fe_1',
    title: 'Deus continua trabalhando',
    theme: 'Fé',
    verseText:
        'Porque vivemos por fé, e não pelo que vemos.',
    verseRef: '2 Coríntios 5:7',
    reflection:
        'Às vezes pensamos que Deus está distante porque ainda não vemos uma resposta. Mas o silêncio de Deus não significa ausência. Muitas vezes Ele está trabalhando nos detalhes que nossos olhos ainda não conseguem perceber.',
    application:
        'Escolha confiar em Deus hoje, mesmo em uma área onde você ainda não recebeu a resposta que espera.',
    prayer:
        'Pai, ajuda-me a confiar no Teu tempo. Que minha fé seja maior do que meus medos e minhas dúvidas. Amém.',
    readingMinutes: 3,
  ),

  Devotional(
    id: 'recomeco_1',
    title: 'Um novo começo',
    theme: 'Recomeço',
    verseText:
        'As misericórdias do Senhor são a causa de não sermos consumidos; renovam-se cada manhã.',
    verseRef: 'Lamentações 3:22-23',
    reflection:
        'Talvez você carregue arrependimentos do passado ou pense que perdeu oportunidades. Mas Deus é especialista em recomeços. Cada manhã é uma oportunidade de levantar, aprender e caminhar novamente com Ele.',
    application:
        'Não permita que um erro do passado defina quem você é hoje. Entregue sua história nas mãos de Deus.',
    prayer:
        'Senhor, obrigado porque Tu me dás novas oportunidades. Ajuda-me a deixar o passado para trás e viver os planos que preparaste para mim. Amém.',
    readingMinutes: 4,
  ),

  Devotional(
    id: 'esperanca_1',
    title: 'Quando Deus parece em silêncio',
    theme: 'Esperança',
    verseText:
        'Esperei com paciência pelo Senhor, e ele se inclinou para mim e ouviu o meu clamor.',
    verseRef: 'Salmos 40:1',
    reflection:
        'Esperar não é fácil. Existem momentos em que oramos e parece que nada acontece. Mas Deus nunca ignora uma oração sincera. Ele trabalha no tempo certo e prepara caminhos que muitas vezes não conseguimos imaginar.',
    application:
        'Continue orando. A demora de Deus não significa que Ele esqueceu de você.',
    prayer:
        'Deus, fortalece minha esperança enquanto espero. Ensina-me a confiar mesmo quando eu não entendo o processo. Amém.',
    readingMinutes: 4,
  ),

  Devotional(
    id: 'familia_1',
    title: 'Cuidando de quem Deus colocou ao seu lado',
    theme: 'Família',
    verseText:
        'Eu e a minha casa serviremos ao Senhor.',
    verseRef: 'Josué 24:15',
    reflection:
        'A família é construída todos os dias através de pequenas atitudes. Uma palavra de carinho, um pedido de perdão e um momento de oração podem transformar um lar.',
    application:
        'Hoje demonstre amor por alguém da sua família através de uma atitude simples.',
    prayer:
        'Senhor, abençoa minha família. Que meu lar seja um lugar de amor, perdão e presença de Deus. Amém.',
    readingMinutes: 3,
  ),

  Devotional(
    id: 'gratidao_1',
    title: 'Agradeça mesmo nos dias difíceis',
    theme: 'Gratidão',
    verseText:
        'Em tudo dai graças, porque esta é a vontade de Deus.',
    verseRef: '1 Tessalonicenses 5:18',
    reflection:
        'A gratidão não significa que todos os dias serão fáceis. Significa reconhecer que, mesmo em meio às dificuldades, Deus continua presente e cuidando de nós.',
    application:
        'Liste três motivos pelos quais você pode agradecer a Deus hoje.',
    prayer:
        'Pai, abre meus olhos para enxergar Tuas bênçãos todos os dias. Que meu coração seja sempre agradecido. Amém.',
    readingMinutes: 3,
  ),

];
