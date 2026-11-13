# Treinamento Flutter: construindo um App de Redes Sociais

Treinamento prático em pares para quem já concluiu o curso de Flutter. Em vez de rever teoria, vamos construir um app completo do zero, juntos, em uma manhã.

- **Data:** ______
- **Horário:** 08:00 às 12:00 (lanche de 15 minutos às 10:00)
- **Formato:** presencial, em pares, 90% prática e 10% teoria
- **Público:** devs júniores

---

## O que vamos construir

Um app de rede social simples, o `app_redes_sociais`, com:

- Tela de **login** autenticando em uma API real.
- **Lista de posts** com avatar, nome, data e contador de notificações.
- **Detalhes** do post.
- Tela para **criar um novo post**.
- **Funcionamento offline**: os posts ficam salvos no celular e continuam aparecendo sem internet.
- **APK** gerado e instalado no celular.

---

## Como funciona o dia

Cada tema segue o mesmo ritmo:

1. **Teoria curta**, de 2 a 5 minutos, só o essencial.
2. **Demonstração** do instrutor construindo o exemplo na tela.
3. **Vocês fazem**: cada par refaz o exemplo no próprio projeto.
4. **Variação**: o instrutor pede um ajuste na hora e vocês aplicam sozinhos.

Algumas regras:

- Vocês trabalham em **pares**, com um notebook por par. Organizem-se como preferirem, mas os dois precisam participar e entender o que está sendo feito.
- Não há provas nem desafios para entregar. O objetivo é aprender fazendo.
- O instrutor só avança quando todos os pares tiverem o resultado funcionando na tela. Se travar, peçam ajuda ao colega de par, ao outro par ou ao instrutor.
- Errar faz parte. Vamos ver os erros mais comuns e como resolvê-los.

---

## Temas e descrição

### 1. Projeto, Widgets e Imagens
Criação do projeto e primeiros widgets: `Scaffold`, `AppBar`, `Column`, `Row`, `Container`, campos de formulário e botões. Também veremos como adicionar imagens SVG ao app (assets). **Resultado:** a tela de Login montada.

### 2. Telas e navegação
Como criar telas e navegar entre elas com o GetX (`Get.to`, `Get.off`, `Get.offAll`, `Get.back`). Também veremos listas com `ListView` e `ListTile`. **Resultado:** a tela de lista de posts e a tela de detalhes, com a navegação entre elas.

### 3. Gerenciamento de estado com GetX
Como separar a lógica da interface: controllers, injeção com `Get.put` e `Get.find`, atualização de tela com `GetXBuilder` e `id`, e controle de carregamento com `isWaiting`. **Resultado:** a lista de posts controlada por um controller, com indicador de progresso.

### 4. API
Como consumir uma API REST com `GetConnect`: login, listagem e criação de posts, conversão de JSON em objetos (models) e tratamento de erros. **Resultado:** login real e posts vindos da internet.

### 5. SQLite
Como guardar os dados no celular com `sqflite`: criação de tabelas, `Store` com as consultas e estratégia de offline-first (a tela sempre lê do banco, e a API alimenta o banco). **Resultado:** o app funcionando com o modo avião ligado.

### 6. APK
Como gerar o instalador do app (`flutter build apk`) e instalar no celular. **Resultado:** o app instalado e rodando fora do ambiente de desenvolvimento.

---

## Programação do dia

- **08:00 às 08:15** Abertura e formação dos pares
- **08:15 às 08:50** Projeto, Widgets e Imagens
- **08:50 às 09:20** Telas e navegação
- **09:20 às 10:00** Estado com GetX
- **10:00 às 10:15** Lanche
- **10:15 às 10:55** API
- **10:55 às 11:35** SQLite
- **11:35 às 11:50** APK
- **11:50 às 12:00** Fechamento e dúvidas

---

## Padrões que usaremos no código

- Páginas somente `StatelessWidget`.
- Navegação apenas com o GetX (`Get.to`, `Get.off`, `Get.offAll`, `Get.back`).
- `GetXBuilder` com `id` para atualizar a tela.
- Variável `isWaiting` para controlar o carregamento sempre que houver chamada de API ou banco de dados.
- Todo código SQL fica dentro da classe `Store`.

---

## O que levar e preparar antes

Cada par deve ter, em **um notebook**:

- Flutter instalado e funcionando (rodem `flutter doctor`). **Todos devem usar a mesma versão do Flutter.** Informem o resultado de `flutter --version` ao instrutor com antecedência.
- Um editor (Android Studio ou VS Code com as extensões Flutter e Dart).
- Um emulador Android ou, de preferência, um **celular Android com cabo USB**.
- Teste prévio: criem um app em branco (`flutter create teste`) e rodem com `flutter run`.
- Conexão com a internet (Wi-Fi) para acessar a API.

Se possível, combinem entre os dois do par quem traz o notebook principal e quem traz o reserva.

---

## Dúvidas?

Falem com o instrutor antes do dia, em especial se o ambiente (Flutter, emulador, celular) não estiver funcionando.
