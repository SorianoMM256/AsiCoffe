# AsiCoffee 2.0

Projeto desenvolvido para a Semana 4-5 da capacitação de Flutter, com foco em navegação, interatividade, gerenciamento de estado global e adaptação visual.

## Objetivo

Evoluir o projeto AsiCoffee 1.0, que era focado na construção visual da interface, para uma versão mais dinâmica e funcional.

Nesta versão, o aplicativo permite cadastrar novos produtos, remover itens do cardápio, favoritar produtos, navegar entre telas, aplicar filtros globais e manter os dados sincronizados entre diferentes partes do app usando Riverpod.

## Funcionalidades

* Tela principal com listagem de produtos do cardápio.
* Cadastro de novos itens por meio de um Modal usando `showModalBottomSheet`.
* Validação de formulário para impedir nome vazio, preço inválido ou data não selecionada.
* Campo de texto para nome do produto.
* Campo numérico para preço.
* `Dropdown` para seleção de categoria.
* `DatePicker` para escolha da data de lançamento.
* `Switch` para indicar se o produto é sem glúten.
* Remoção de produtos com `Dismissible`.
* `SnackBar` com opção de desfazer remoção.
* Tela de detalhes do produto.
* Passagem de dados entre telas.
* Navegação inferior por abas com `NavigationBar`.
* Aba de Cardápio.
* Aba de Favoritos.
* Menu lateral com `Drawer`.
* Filtros globais para mostrar apenas cafés ou apenas produtos sem glúten.
* Gerenciamento de estado global com Riverpod.
* Lista global de produtos usando `StateNotifierProvider`.
* Favoritos sincronizados entre cardápio, detalhes e aba de favoritos.
* Filtros globais controlados por provider.
* Tema claro e tema escuro usando `ThemeData`, `ColorScheme` e Material 3.
* Responsividade básica usando `LayoutBuilder`.
* Uso do pacote `google_fonts`.

## Tecnologias utilizadas

* Flutter
* Dart
* Riverpod
* Google Fonts
* Material 3
* Git e GitHub

## Estrutura principal do projeto

```txt
lib/
├── main.dart
├── home_page.dart
├── card_item.dart
├── item_cafe.dart
├── data_cafe.dart
├── providers.dart
├── new_item_modal.dart
└── item_details_page.dart
```

## Principais mudanças em relação ao AsiCoffee 1.0

Na primeira versão, o projeto tinha como foco a construção da interface visual, com uma lista de produtos, imagens por URL, textos estilizados e favorito local no card.

Na versão 2.0, o projeto foi expandido para trabalhar com dados dinâmicos e estado global. Agora os produtos podem ser cadastrados e removidos durante o uso do app, os favoritos são sincronizados entre telas, os filtros afetam a listagem principal e a navegação foi organizada com abas, Drawer e tela de detalhes.

## Gerenciamento de estado

O projeto utiliza Riverpod para controlar estados globais importantes da aplicação.

Foram criados providers para:

* gerenciar a lista de produtos;
* controlar os produtos favoritos;
* gerar a lista de produtos favoritados;
* armazenar os filtros globais;
* gerar a lista filtrada do cardápio.

Com isso, alterações feitas em uma parte do app são refletidas automaticamente em outras telas.

## Como executar o projeto

Clone o repositório:

```bash
git clone LINK_DO_REPOSITORIO
```

Entre na pasta do projeto:

```bash
cd AsiCoffe
```

Instale as dependências:

```bash
flutter pub get
```

Execute no navegador:

```bash
flutter run -d chrome
```

## Autor

Matheus Motta Soriano
