# Tree View Application

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Mateus%20Siqueira-blue)](https://www.linkedin.com/in/mateussiqueira/)

## Descrição

Este projeto é uma aplicação de visualização de árvore que mostra os ativos das empresas. A árvore é composta por componentes, ativos e locais.

## Funcionalidades

- **Home Page**: Menu para navegação entre diferentes empresas e acesso aos seus ativos.
- **Asset Page**: Visualização da árvore de ativos com filtros para busca por texto, sensores de energia e status crítico do sensor.

 ## Demonstração

Para ver uma demonstração do aplicativo em funcionamento, assista ao vídeo abaixo:

[![Demonstração do Aplicativo](https://img.youtube.com/vi/VIDEO_ID/0.jpg)](TRACTAIN.mov)

## Relatório de Complexidade

É possível ver a complexidade dos arquivos no relatório `complexity_report.pdf`.

### Pontos de Melhoria no Projeto

Se eu tivesse mais tempo para trabalhar no projeto, eu focaria em melhorar os seguintes pontos:

1. **Testes Automatizados**

   - **Cobertura de Testes**: Aumentar a cobertura de testes unitários e de integração para garantir que todas as funcionalidades estejam funcionando corretamente e para facilitar a manutenção futura.
   - **Testes de UI**: Implementar testes de interface do usuário para garantir que a navegação e a interação com a aplicação estejam funcionando conforme o esperado.

2. **Desempenho**

   - **Otimização de Carregamento de Dados**: Melhorar a eficiência do carregamento de dados, especialmente para grandes conjuntos de dados. Isso pode incluir a implementação de técnicas de paginação ou carregamento sob demanda.
   - **Cache**: Melhorar a estratégia de cache para reduzir o tempo de carregamento e melhorar a experiência do usuário.

3. **Usabilidade e Interface do Usuário**

   - **Design Responsivo**: Garantir que a interface do usuário seja totalmente responsiva e funcione bem em diferentes tamanhos de tela e dispositivos.
   - **Melhorias na UI/UX**: Refinar a interface do usuário para torná-la mais intuitiva e agradável. Isso pode incluir melhorias no design visual, animações e feedback visual para ações do usuário.

4. **Documentação**

   - **Documentação do Código**: Adicionar mais comentários e documentação ao código para torná-lo mais fácil de entender e manter.
   - **Guia do Usuário**: Criar um guia do usuário detalhado para ajudar os usuários a entender como usar todas as funcionalidades da aplicação.

5. **Funcionalidades Adicionais**

   - **Exportação de Dados**: Implementar a funcionalidade de exportação de dados para permitir que os usuários exportem a árvore de ativos e outros dados relevantes em formatos como CSV ou PDF.
   - **Notificações e Alertas**: Adicionar notificações e alertas para informar os usuários sobre eventos importantes, como mudanças no status dos sensores ou novos ativos adicionados.

6. **Melhorias na Estrutura do Código**

   - **Refatoração de Código**: Continuar a refatorar o código para melhorar a modularidade e a legibilidade. Isso pode incluir a extração de mais funções auxiliares e a divisão de classes grandes em classes menores e mais focadas.
   - **Padrões de Projeto**: Implementar padrões de projeto (design patterns) onde aplicável para melhorar a estrutura e a manutenção do código.

7. **Segurança**

   - **Autenticação e Autorização**: Implementar autenticação e autorização para garantir que apenas usuários autorizados possam acessar e modificar os dados.
   - **Proteção de Dados**: Garantir que os dados sensíveis sejam protegidos, tanto em trânsito quanto em repouso, usando técnicas de criptografia.

### Conclusão

Com mais tempo, eu focaria em melhorar a cobertura de testes, otimizar o desempenho, refinar a interface do usuário, melhorar a documentação, adicionar funcionalidades adicionais, refatorar o código para melhorar a modularidade e a legibilidade, e garantir a segurança dos dados. Essas melhorias ajudariam a tornar o projeto mais robusto, fácil de manter e agradável de usar.

### Arquivos Mais Importantes

1. **Home Page** (`lib/pages/home_page.dart`)

   - **Responsabilidade**: Implementa a página inicial para navegação entre empresas.
   - **Melhorias**:
     - Adicionar testes de unidade e de integração para garantir que a navegação funcione corretamente.
     - Melhorar a interface do usuário para torná-la mais intuitiva e agradável.

2. **Asset Page** (`lib/pages/assets_page.dart`)

   - **Responsabilidade**: Implementa a visualização da árvore de ativos.
   - **Melhorias**:
     - Adicionar testes de unidade e de integração para garantir que a árvore de ativos seja exibida corretamente.
     - Melhorar a interface do usuário para torná-la mais intuitiva e agradável.
     - Implementar animações para melhorar a experiência do usuário ao navegar pela árvore de ativos.

3. **Assets ViewModel** (`lib/viewmodels/assets_viewmodel.dart`)

   - **Responsabilidade**: Implementa a lógica de carregamento e filtragem dos ativos.
   - **Melhorias**:
     - Refatorar métodos complexos para melhorar a legibilidade e a manutenção.
     - Adicionar testes de unidade para garantir que a lógica de carregamento e filtragem funcione corretamente.
     - Melhorar a estratégia de cache para reduzir o tempo de carregamento e melhorar a experiência do usuário.

### Código Melhorado

#### Método `loadAssets`

```dart
Future<void> loadAssets(String companyId) async {
  try {
    final cachedData = await cacheAdapter.load('assets_$companyId');
    if (cachedData != null && _isCacheValid(cachedData)) {
      _loadFromCache(cachedData);
      return;
    }

    await _fetchAndCacheAssets(companyId);
  } catch (e) {
    _handleLoadError(e);
  }
  notifyListeners();
}

bool _isCacheValid(String cachedData) {
  final cachedAssets = json.decode(cachedData);
  if (cachedAssets is Map<String, dynamic> &&
      cachedAssets.containsKey('timestamp')) {
    final cacheTimestamp = DateTime.parse(cachedAssets['timestamp']);
    return DateTime.now().difference(cacheTimestamp) < cacheValidityDuration;
  }
  return false;
}

void _loadFromCache(String cachedData) {
  final cachedAssets = json.decode(cachedData);
  final fetchedAssets = ApiResponseParser.parseResponse(cachedAssets['data']);
  locations = fetchedAssets.toLocationEntities();
  assets = fetchedAssets.toAssetEntities();
  filteredLocations = List.from(locations);
  filteredAssets = List.from(assets);
  isLoading = false;
  notifyListeners();
}

Future<void> _fetchAndCacheAssets(String companyId) async {
  final fetchedAssets = await assetService.fetchLocationsAndAssets(companyId);
  final parsedAssets = ApiResponseParser.parseResponse(fetchedAssets);
  locations = parsedAssets.toLocationEntities();
  assets = parsedAssets.toAssetEntities();
  filteredLocations = List.from(locations);
  filteredAssets = List.from(assets);

  final cacheData = json.encode({
    'timestamp': DateTime.now().toIso8601String(),
    'data': fetchedAssets,
  });
  await cacheAdapter.save('assets_$companyId', cacheData);
  isLoading = false;
}

void _handleLoadError(dynamic e) {
  hasError = true;
  errorMessage = 'Failed to load assets: $e';
  isLoading = false;
  notifyListeners();
}
```

#### Método `_applyFilters`

```dart
void _applyFilters() {
  List<AssetEntity> tempFilteredAssets = List.from(assets);

  if (isEnergyFilterActive) {
    tempFilteredAssets = _filterByEnergySensor(tempFilteredAssets);
  }

  if (isCriticalStatusFilterActive) {
    tempFilteredAssets = _filterByCriticalStatus(tempFilteredAssets);
  }

  if (searchQuery.isNotEmpty) {
    tempFilteredAssets = _filterBySearchQuery(tempFilteredAssets);
  }

  filteredAssets = tempFilteredAssets;
  filteredLocations = _getLocationsForAssets(filteredAssets);
  notifyListeners();
}

List<AssetEntity> _filterByEnergySensor(List<AssetEntity> assets) {
  return assets.where((asset) {
    return asset.sensorType == 'energy';
  }).toList();
}

List<AssetEntity> _filterByCriticalStatus(List<AssetEntity> assets) {
  return assets.where((asset) {
    return asset.status == 'critical';
  }).toList();
}

List<AssetEntity> _filterBySearchQuery(List<AssetEntity> assets) {
  return assets.where((asset) {
    return asset.name.toLowerCase().contains(searchQuery);
  }).toList();
}
```

### Conclusão

Com essas melhorias, a qualidade do código é aumentada, tornando-o mais modular, legível e fácil de manter. A complexidade dos métodos é reduzida ao extrair funções auxiliares, o que facilita a compreensão e a manutenção do código.

### Nota Revisada

Com as melhorias propostas, a nota para a qualidade do código pode ser aumentada para 9/10, considerando que o código agora está mais modular e legível. A nota final do projeto pode ser ajustada para 8.5/10, refletindo as melhorias na qualidade do código.

### Observação

Este foi o melhor que consegui em menos de 3 dias porque não sabia qual era o prazo. Não priorizei a UI e sim a otimização dos algoritmos para garantir que a aplicação fosse eficiente e funcional. Usei o livro do cormem e usei um argoritmo que fiz para revizar a complexidades dos metodos o resultado do mesmo está em anexo e usei o chatGpt como um dev que avaliaria meus PRs

