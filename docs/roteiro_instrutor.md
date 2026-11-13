# Roteiro do Instrutor: Treinamento Flutter em Pares

Data: ______ | Horário: 08:00 às 12:00 | Lanche: 10:00 às 10:15 | 6 devs em 3 pares | Sem FVM

Documento de uso interno. O material dos alunos está em `docs/treinamento_flutter_alunos.md`.

---

## 0. Como usar este roteiro

Cada bloco tem a mesma estrutura:

- **Tempo**: janela do bloco.
- **Teoria** (2 a 5 min): frases-chave para falar antes de codar.
- **Demo** (8 a 12 min): o que você codifica, passo a passo, falando o que pensa. Os pares só assistem.
- **Réplica**: o par refaz a demo no próprio projeto.
- **Variação**: o ajuste que você pede na hora.
- **Pronto quando**: o que precisa aparecer na tela dos 3 pares para você avançar.
- **Erros comuns**: problemas prováveis e a solução em uma linha.

Regras de condução:

- Só avance quando os 3 pares estiverem no "Pronto quando". Se um par atrasar, o colega de par ajuda primeiro, depois o outro par.
- Durante as verificações, pergunte a qualquer um dos dois "por que fizemos isso?" para garantir que ambos acompanham.
- Não há checkpoints no git nem desafios. O seu repositório final é só consulta.
- Mantenha um cronômetro visível. A agenda tem pouca folga.
- Todos os comandos são `flutter ...` (sem FVM).

### Convenções do projeto (falar na abertura e repetir quando surgir)

- Páginas somente `StatelessWidget`.
- Navegação só com `Get.to`, `Get.off`, `Get.offAll` e `Get.back()`. Nada de `Navigator`.
- Nunca `Get.arguments`, `FutureBuilder` ou `addPostFrameCallback`.
- `GetXBuilder` com `id`. Nada de `GetBuilder(init:)`.
- Todo método que acessa banco ou API usa `isWaiting`. Na interface: se `isWaiting`, mostra `CircularProgressIndicator`, senão os widgets normais.
- SQL só dentro de `Store`.
- Não passar `BuildContext` como parâmetro de função.

### Ordem de cortes se o tempo apertar

1. `addPost` completo (bloco API): você faz sozinho e eles só observam.
2. Instalar o APK nos 3 pares: instale só no seu celular.
3. A variação do bloco de telas.

---

## 1. Pré-checagens antes do dia

Faça no seu projeto de referência e confirme com os pares:

- [ ] `flutter --version` igual em todos os notebooks dos pares.
- [ ] Cada par rodou um `flutter run` de um app em branco, em emulador ou celular real.
- [ ] A API `https://pray4ever.com/curso` responde: login (`POST /usuario/autenticar`), listar posts (`GET /posts/listar/{id}`) e adicionar post (`POST /post/add`).
- [ ] Anote aqui o login e a senha de teste: login ______ senha ______.
- [ ] `pubspec.yaml`: a restrição `sdk: ">=2.15.0 <3.0.0"` está compatível com a versão do Flutter dos alunos. Ajuste e rode `flutter pub get` e `flutter run` na versão que será usada.
- [ ] Os assets estão em `assets/images/`: `feliz.svg`, `insta.svg`, `rosto-homem.svg`, `rosto-mulher.svg`, `rosto-jovem.svg`, `praia.svg`, `camisa.svg`. Atenção: `AddPostPage` usa `assets/images/new_post.svg`, que **não está** na pasta. Adicione o arquivo antes do dia ou troque por um dos existentes, senão a tela de novo post quebra.
- [ ] Permissão de internet no `android/app/src/main/AndroidManifest.xml` (`android.permission.INTERNET`) e `usesCleartextTraffic` não é necessário, pois a API usa HTTPS.
- [ ] Plano B da API: já implementado em `lib/api/api_local_mock.dart`. Ative com `apiTesteLocal = true` (login `teste`, senha `123`). Veja a seção 10.

Ajustes no seu projeto para estarem de acordo com as convenções (recomendado antes do dia):

- `lib/posts/posts_page.dart`: trocar `GetBuilder<MainController>` por `GetXBuilder` com `id`, e usar `isWaiting`.
- `lib/controllers/main_controller.dart`: adicionar `isWaiting` em `autenticar`, `listarPosts` e `addPost`, e chamar `super.onInit()` no `onInit`.
- `lib/login/login_page.dart`: mostrar o progresso durante o login.
- `lib/main.dart`: remover imports não usados (`detalhes_post`, `badges`, `flutter_svg`).
- `lib/api/api_connect.dart`: tratar rede indisponível (o `catchError` hoje deixa `response` sem valor útil).

---

## 2. Abertura

**Tempo:** 08:00 a 08:15 (15 min)

**Teoria (5 min):** arquitetura em camadas, desenhada no quadro:

```
UI (Page) -> Controller (GetX) -> ApiConnect (rede)
                               -> Store (SQL) -> DBService (sqflite)
```

Frases-chave:

- "A tela só desenha. Quem decide é o controller."
- "A API fala com a rede. O Store fala com o banco. Cada um só faz o seu trabalho."
- "Hoje vocês já viram tudo isso no curso. Aqui vamos juntar as peças e errar com calma."

**O que fazer (10 min):**

1. Forme os 3 pares (misturando níveis) e peça que sentem juntos com um notebook por par.
2. Mostre o app final rodando no seu celular: login, lista de posts, detalhes, novo post, modo avião funcionando.
3. Explique o formato: demo, réplica, variação, verificação. Sem desafios. Pares livres para se organizarem.
4. Apresente as convenções do projeto e o cronograma.

**Pronto quando:** todos os pares conseguem abrir o emulador ou celular e rodar `flutter run` (um app em branco serve).

**Erros comuns:**

- Emulador lento: use celular real conectado por USB, se possível.
- `flutter doctor` com erro de licença Android: `flutter doctor --android-licenses`.

---

## 3. Projeto, Widgets e Imagens

**Tempo:** 08:15 a 08:50 (35 min)

**Teoria (3 min):** tudo é widget; árvore de widgets; `StatelessWidget` x `StatefulWidget`.

Frases-chave:

- "Tela é uma árvore de widgets. Pai envolve filho."
- "Nossas páginas são `StatelessWidget`. O estado mora no controller, não na tela."

**Demo (12 min):** criar o projeto e a tela de Login só com a interface.

1. `flutter create app_redes_sociais` e abrir o projeto (os pares já criaram o projeto; o `flutter create` deles pode ser feito aqui, junto com a demo).
2. Em `lib/main.dart`: `GetMaterialApp` com `title`, `debugShowCheckedModeBanner: false`, `theme` e `home: LoginPage()`.
3. Em `lib/login/login_page.dart`: `LoginPage extends StatelessWidget`.
4. `Scaffold` com `AppBar(title: Text('Login'))`.
5. `body: Container(padding: EdgeInsets.all(20), child: Column(...))` com dois `TextFormField`: Login (`labelText: 'Login'`) e Senha (`obscureText: true`).
6. `bottomSheet: MaterialButton(...)` com `color: Colors.blue`, `height: 50`, `minWidth: 400` e `Text('Login')` branco.
7. Declarar `assets/` e `assets/images/` no `pubspec.yaml`, adicionar `flutter_svg` e rodar `flutter pub get`.
8. Mostrar `SvgPicture.asset('assets/images/feliz.svg')` na tela.

**Réplica:** o par refaz a tela de Login no projeto.

**Variação (pedida na hora):** adicionar o logo SVG acima dos campos, com `SizedBox` de espaçamento; trocar a cor do botão.

**Pronto quando:** a tela de Login aparece no emulador, com campos digitáveis, botão azul e o SVG carregado.

**Erros comuns:**

- SVG não aparece: asset não declarado no `pubspec.yaml` (indentação do YAML) ou `flutter pub get` não rodado.
- "RenderFlex overflowed" ao abrir o teclado: envolver com `SingleChildScrollView` ou aceitar como tema de conversa.
- `hot reload` não reflete mudança no `pubspec.yaml`: parar e rodar `flutter run` de novo.

---

## 4. Telas e navegação

**Tempo:** 08:50 a 09:20 (30 min)

**Teoria (3 min):** pilha de rotas do Get.

Frases-chave:

- "`Get.to` empilha, `Get.off` troca a atual, `Get.offAll` limpa tudo e vai para uma nova."
- "Depois do login a gente usa `Get.offAll`, porque o usuário não deve voltar para o Login com o botão voltar."

**Demo (10 min):** `PostsPage` com lista fixa e ida para `DetalhesPostPage`.

1. Criar `lib/models/post_model.dart` e `lib/models/usuario_model.dart` simples, com `texto`, `data` e `usuarioPost` (nome, avatar, notificações).
2. Criar `lib/posts/posts_page.dart` com `Scaffold`, `AppBar` com `Row` (ícone `feliz.svg` + título) e `ListView.separated` com `ListTile` e `Divider`.
3. Usar uma lista fixa de 3 posts (dados falsos).
4. Mostrar `leading` com `CircleAvatar`, `title` com `Row` e `Expanded`, `trailing` com `IconButton`.
5. Criar `lib/posts/detalhes_post.dart` (`final Post post;` recebido pelo construtor: **sem `Get.arguments`**).
6. `onPressed: () => Get.to(DetalhesPostPage(post: post))`.
7. Trocar o `home` do `GetMaterialApp` para testar a navegação e depois fazer o botão do Login chamar `Get.offAll(PostsPage())` por enquanto sem validar nada.

**Réplica:** o par monta `PostsPage` e `DetalhesPostPage`.

**Variação (pedida na hora):** adicionar um `FloatingActionButton` que abre `AddPostPage` (só uma tela com `AppBar` "Nova postagem"). Mostrar `Get.back()` para voltar.

**Pronto quando:** do Login chega-se à lista, toca no ícone do post e vê os detalhes; o FAB abre a nova tela e o botão voltar funciona.

**Erros comuns:**

- "Navigator operation requested with a context that does not include a Navigator": `GetMaterialApp` faltando no `main.dart`.
- `ListView` dentro de `Column` sem altura: envolver com `Expanded`.
- Usar `Navigator.pop`: lembrar que o padrão do projeto é `Get.back()`.

---

## 5. Estado com GetX

**Tempo:** 09:20 a 10:00 (40 min)

**Teoria (4 min):** por que separar lógica da tela.

Frases-chave:

- "Controller guarda o estado e as regras. A tela observa e redesenha."
- "`update()` avisa os `GetXBuilder` com o `id`. Sem `id`, todo mundo redesenha."
- "`isWaiting` liga e desliga o progresso: sempre que tem API ou banco, usamos."

**Demo (14 min):** mover a lista fixa para o `MainController`.

1. Criar `lib/controllers/main_controller.dart` com `class MainController extends GetxController`.
2. Campos: `List<Post> posts = []` e `bool isWaiting = false`.
3. `main.dart`: `initialBinding: BindingsBuilder(() { Get.put(MainController()); })`.
4. Nas páginas: `MainController controller = Get.find();`.
5. Em `PostsPage`: usar `GetXBuilder<MainController>` com `id: 'lista-posts'` e, dentro, `if (controller.isWaiting) CircularProgressIndicator else ListView`.
6. Método `listarPosts()`: `isWaiting = true; update(['lista-posts']);` carregar os dados fixos; `isWaiting = false; update(['lista-posts']);`.
7. Demonstrar o badge: pacote `badges`, `Badge(showBadge: ..., badgeContent: ..., child: CircleAvatar(...))`; ao abrir o post, `notificacoes` diminui e `controller.update(['lista-posts'])` redesenha só a lista.

**Réplica:** o par move a lista para o controller e usa `GetXBuilder` com `id`.

**Variação (pedida na hora):** mostrar o `CircularProgressIndicator` por 2 segundos simulados (`await Future.delayed(...)`) antes de exibir a lista, para ver o `isWaiting` funcionando.

**Pronto quando:** a lista aparece depois do progresso, e o badge muda ao abrir um post sem recarregar a tela toda.

**Erros comuns:**

- "Get.find: MainController not found": faltou o `Get.put` no `initialBinding`.
- Tela não atualiza: esqueceu o `update(['id'])` ou o `id` do `GetXBuilder` não bate.
- Tentar `StatefulWidget`/`setState`: reforçar que o estado está no controller.

---

## Lanche

**Tempo:** 10:00 a 10:15

Aproveite para ver quem está atrasado e ajudar sem pressão. Se algum par não conseguiu fechar GetX, ajude agora.

---

## 6. API

**Tempo:** 10:15 a 10:55 (40 min)

**Teoria (4 min):** `GetConnect`, HTTP e o significado de `null`.

Frases-chave:

- "Status 200 é sucesso. Qualquer outra coisa é falha e a tela precisa saber."
- "`null` aqui quer dizer 'não deu certo'. Quem chamou decide o que mostrar."
- "A API nunca é chamada pela tela. É chamada pelo controller."

**Demo (14 min):** login real e lista real.

1. Criar `lib/api/api_connect.dart`: `class ApiConnect extends GetConnect` com `defaultUrl = 'https://pray4ever.com/curso'`.
2. Completar os models `Usuario` e `Post` com `fromJson` e `toJson`.
3. Método `autenticar(login, senha)`: `post('$defaultUrl/usuario/autenticar', {"login": login, "senha": senha})`; se `response.status.code == 200`, `Usuario.fromJson(response.body)`.
4. No `MainController`: `autenticar` com `isWaiting`, `Get.snackbar('Erro', ...)` em falha e `Get.offAll(PostsPage())` em sucesso.
5. `LoginPage`: `Get.find<MainController>().autenticar(login, senha)` e mostrar o progresso enquanto `isWaiting`.
6. Método `listarPosts(int id)` na API: `get('$defaultUrl/posts/listar/$id')` e converter a lista com `map(Post.fromJson)`.
7. No controller, `listarPosts(0)` chama a API e atualiza a lista.

**Réplica:** o par implementa login e lista com a API.

**Variação (pedida na hora, se o tempo permitir):** `addPost` em `ApiConnect` (`POST /post/add`), com `Form`, `GlobalKey<FormState>` no controller, `validator` do campo texto e `Get.offAll(PostsPage())` depois de salvar.

**Pronto quando:** o login com os dados de teste leva à lista com posts reais; login inválido mostra o snackbar de erro.

**Erros comuns:**

- Login sempre falha: URL, login ou senha errados; imprima `response.statusCode` e `response.body` para ver.
- `type 'Null' is not a subtype...` ao converter: algum campo do JSON vem nulo. Mostre como tratar com `?`.
- Sem internet no emulador ou celular: conferir Wi-Fi e permissão `INTERNET` no Manifest.
- `response` nulo com `catchError` quando a rede cai: mostre isso como bug real e como tratar.

---

## 7. SQLite

**Tempo:** 10:55 a 11:35 (40 min)

**Teoria (4 min):** offline-first.

Frases-chave:

- "A tela lista sempre do banco local. A API só alimenta o banco."
- "Se não tem internet, o app continua funcionando com o que já foi salvo."
- "Todo SQL fica no `Store`. O controller nunca escreve SQL."

**Demo (14 min):** persistir os posts e provar o offline.

1. Adicionar `sqflite` e `connectivity_plus` no `pubspec.yaml`.
2. Criar `lib/data/db_service.dart`: singleton `DBService` com `getDatabasesPath()` e `openDatabase(..., onCreate:)`.
3. `_onCreate`: `CREATE TABLE usuario(...)` e `CREATE TABLE post(...)` (`id_usuario`, `data`, `imagem`).
4. Criar `lib/data/store.dart` com `insertUsuario`, `insertPost`, `findUsuario`, `findPost` e `listPosts` usando `rawQuery` e `insert`.
5. Em `Post` e `Usuario`: `toMap` e `fromMap` (mostre a diferença entre `toJson` com `idUsuario` e `toMap` com `id_usuario`).
6. No controller, `conexaoWebOK()` com `Connectivity().checkConnectivity()`.
7. `listarPosts(id)`: se tem internet, busca na API; grava no banco (usuário e post se ainda não existem); no final, `posts = await store.listPosts();` e `update(['lista-posts'])`.

**Réplica:** o par persiste os posts e lista a partir do banco.

**Variação (pedida na hora):** ligar o modo avião, fechar o app e abrir de novo: a lista continua aparecendo.

**Pronto quando:** com a internet ligada a lista carrega; com modo avião o app abre e mostra os posts salvos.

**Erros comuns:**

- `no such table`: o banco foi criado antes de você mudar o script. Desinstale o app do emulador ou celular, ou aumente `versaoBD` e trate `onUpgrade`.
- `UNIQUE constraint failed`: tentou inserir um `id` que já existe. Mostre o `findPost` antes de inserir.
- `usuarioPost` nulo na lista: faltou preencher o usuário em `listPosts()` ou `findPost`.
- `Connectivity` retorna lista (versões novas): usar `result.contains(ConnectivityResult.none)`, como no projeto.

---

## 8. APK

**Tempo:** 11:35 a 11:50 (15 min)

**Teoria (2 min):** debug x release.

Frases-chave:

- "O que a gente roda no dia a dia é debug. O APK é release e é o que vai para outras pessoas."
- "O primeiro build demora. Por isso começamos agora."

**Demo (5 min):** `flutter build apk` (dispare no início do bloco, junto com os pares, e comente enquanto roda).

1. `flutter build apk`.
2. Mostrar onde está o arquivo: `build/app/outputs/flutter-apk/app-release.apk`.
3. Instalar no celular (cabo ou compartilhamento do arquivo).

**Réplica:** os 3 pares geram o APK e instalam em um celular.

**Variação:** nenhuma.

**Pronto quando:** o APK foi gerado nos 3 pares (instalado em pelo menos um celular).

**Erros comuns:**

- Falha por falta de licenças ou SDK: `flutter doctor`.
- Build lento: normal no primeiro; começar cedo.
- App abre e não acessa a internet no release: faltou permissão `INTERNET` no `AndroidManifest.xml` principal (não só no `debug`).

---

## 9. Fechamento

**Tempo:** 11:50 a 12:00 (10 min)

**O que fazer:**

1. Cada par conta em 1 minuto o que construiu e o que mais travou.
2. Dúvidas conceituais que ficaram.
3. Próximos passos sugeridos: o que estudar a partir daqui (testes, navegação nomeada, injeção de dependência, autenticação com token, animações).
4. Compartilhar o seu repositório de referência (consulta) e o material dos alunos.

---

## 10. Plano B se a API cair

O plano B já está implementado como uma caixa-preta isolada em `lib/api/api_local_mock.dart`.

- **Como ativar ou desativar:** altere a constante `apiTesteLocal` no topo desse arquivo. `true` usa a API local (sem rede); `false` usa a API real.
- **Credenciais da API local:** login `teste`, senha `123` (também existem `ana` e `bruno`, senha `123`). Qualquer outra combinação falha, o que serve para demonstrar o snackbar de erro.
- **O que ela simula:** `autenticar`, `listarPosts` e `addPost`, com 5 posts iniciais e 700 ms de espera, para o `isWaiting` aparecer. Os posts criados ficam só em memória e somem ao reiniciar o app (o SQLite do celular mantém o que já foi salvo).
- **Onde ela se conecta:** só no `ApiConnect`, com 3 linhas `if (apiTesteLocal) return ApiLocalMock...`. O controller, as páginas e o `Store` não sabem que existe um mock.
- **Offline:** com `apiTesteLocal = true`, a demo de modo avião continua funcionando, porque o controller ainda checa a conexão antes de chamar a API.
- **Imagens:** a API local usa os SVGs da pasta `assets/images/` (`rosto-jovem`, `rosto-mulher` e `rosto-homem` como avatares; `praia`, `camisa`, `insta` e `feliz` nos posts), sem precisar de internet. O widget `lib/widgets/svg_imagem.dart` carrega do asset quando o caminho começa com `assets/` e da internet quando é uma URL, então a API real continua funcionando.
- **Dados antigos no celular:** se o app já guardou posts no SQLite com outras imagens, desinstale o app ou limpe os dados dele, porque o `Store` não regrava posts que já existem.
- **Para remover o plano B do projeto:** apague `api_local_mock.dart`, o import e os 3 `if (apiTesteLocal)` em `api_connect.dart`.
- **Na demo do bloco de API:** diga aos pares "a API caiu, vamos usar uma API local de teste". Os blocos de GetX, SQLite e APK funcionam igual.

Se for ensinar a API real mesmo assim, deixe `apiTesteLocal = false` no projeto dos alunos e `true` só na sua máquina como reserva.

## 11. Material de apoio a preparar

- Um cronômetro visível em outra tela ou no projetor.
- Uma pasta compartilhada com os SVGs e, se quiser, um arquivo de snippets (login, lista, controller).
- A lista dos 3 pares e os notebooks.
