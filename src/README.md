# O Código

## Oracle

O contrato Oracle é um código já pronto para acessar uma API.

```
constructor(string memory reqURL_, string memory path_, uint256 decimals_)
```

* `reqURL_` - url da API que deseja-se acessar
* `path_` - como acessar a url (e.g se a resposta da url for uma lista de objetos
```
[
{
    gols: 2,
    jogos: 4
},
{
    gols: 7,
    jogos: 5
}

]
```
e voce deseja acessar os gols do segundo item, se deve passar "1,gols")

* `decimals` - para multiplicar caso resultado não seja inteiro (solidity apenas armazena inteiros)

A função `requestRate` faz a requisição para o contrato da chainlink obter o dado e encaminhar de volta para você. E a função `fulfill` é uma função de callback chamada para realizar manipulações com o dado desejado.
