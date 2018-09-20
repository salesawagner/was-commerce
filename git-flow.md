# Git-flow

##Branches

### Branches de base
- Branch de produção: **master**
- Branch de teste e versionamento: **beta**
- Branch do próximo release: **development**

### Nomear branches
- Branch de feature: **feature/[feature-name]**
- Branch de refactor: **refactor/[refactor-description]**
- Branch de fix: **fix/[fix-description]**

### Nomenclatura
- Sempre escrito em inglês;
- Sempre escrito em minusculo;
- Usar apenas letras e numeros, quando precisar utilizar espaço, usar o caracter **-**. Exemplo: **`feature/my-login`**. Para tags de release, usar pontos. Exemplo: **`release-v1.0.0-b51`**;

## Features
Crie a branch a partir da branch **`development`**, use o prefixo  **`feature/`** e o nome da feature. 

**Flow:**
> Start: **`development` -- create branch >> `feature/login`**
> 
> Done: **`feature/login` -- merge >> `development`**

---

## Refactor
Crie a branch a partir da branch **`development`** para refazer algum refactor, use o prefixo  **`refactor/`** e a descrição do refactor. 

**Flow:**
> Start: **`development` -- create branch >> `refactor/remove-old-code`**
> 
> Done: **`refactor/remove-old-code` -- merge >> `development`**

## Fix

Crie a branch a partir da branch **`development`** quando houver a necessidade de fazer algum fix, use o prefixo  **`fix/`** e a descrição do fix. 

**Flow:**
> Start: **`development` -- create branch >> `fix/login`**
> 
> Done: **`fix/login` -- merge >> `development`**

## Beta
A branch beta recebe merge da branch development. Aqui é feito o versionamento e criado a tag para submeter para produção:

**Flow:**
> Start: **`development` -- merge >> `beta`**
> 
> Done: **`beta` -- create tag >> `release-v1.0.1-b10`** 

**Note:** 
> A branch beta só faz merge com a branch development e isso só eh feito quando o release está pronto para produção.


## Master
A branch master recebe merge da branch beta. Esse é o código de produção.

**Exemplo:**

```
$ git checkout -b release/v1.0.1-b10 release-v1.0.1-b10
$ git checkout master
$ git merge release/v1.0.1-b10
$ git push origin
$ git branch -d release/v1.0.1-b10
```

**Flow:**
> Store: **`release-v1.0.1-b10` -- create branch >> `release/v1.0.1-b10`**
> 
> Update master: **`release/v1.0.1-b10` -- merge >> `release/v1.0.1-b10`**
> 
> Done: **`release/v1.0.1-b10 ` -- >> remove branch.**